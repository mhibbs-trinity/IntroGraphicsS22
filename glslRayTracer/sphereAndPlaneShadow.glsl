#define PROCESSING_TEXTURE_SHADER
#define PI 3.1415926535897932384626433832795
#define EPSILON 0.0001

uniform sampler2D sphTex;
uniform vec3 litPos;
uniform vec3 camPos;

varying vec4 vertTexCoord;

/***************** SPHERES *****************/
struct Sphere {
  vec4 pt; //xyz is center point; w is radius
  vec3 col;
};

Sphere s1;

/* Intersection, normal, and textuer calculation for a sphere */
float iSphere(in vec3 ro, in vec3 rd, in vec4 sph) {
	vec3 oc = ro - sph.xyz;
	float b = 2.0 * dot(oc,rd);
	float c = dot(oc,oc) - sph.w*sph.w;
	float d = b*b - 4.0*c;
	if(d < 0.0) return -1.0;
	//Refraction requires getting "hits" on the sphere on the far
	//side, so both the + and - need to be checked
	float t1 = (-b - sqrt(d)) / 2.0;
	float t2 = (-b + sqrt(d)) / 2.0;
	if(t1 > 0.0)
		if(t2 > 0.0) return min(t1,t2);
		else return t1;
	else if(t2 > 0.0) return t2;
	else return -0.5;
}
vec3 nSphere(in vec3 pos, in vec4 sph) {
	return normalize((pos - sph.xyz) / sph.w);
}
vec2 uvSphere(in vec3 pos, in vec4 sph) {
  vec3 norm = nSphere(pos, sph);
  float v = (asin(norm.y) + PI/2) / PI;
  float u = (atan(norm.x, norm.z) + PI) / (2 * PI);
  return vec2(u,v);
}

/***************** PLANES *****************/
struct Plane {
  vec3 pt; //Some point in the (infinite) plane
  vec3 norm;
  vec3 col;
};

const int numPlanes = 6;
Plane planes[numPlanes];

/* Intersection calculation for a(n infinite) plane */
float iPlane(in vec3 ro, in vec3 rd, in vec3 p, in vec3 n) {
  return dot(p - ro, n) / dot(rd, n);
}

/* Intersection with all planes - returns the t value and planeID */
float isectAllPlanes(in vec3 ro, in vec3 rd, out int pid) {
  float t = 10000;
  pid = -1;
  for(int i=0; i<numPlanes; i++) {
    float tp = iPlane(ro + EPSILON * rd, rd, planes[i].pt, planes[i].norm);
    if(tp > 0 && tp < t) {
      t = tp;
      pid = i;
    }
  }
  return t;
}

/* Closest intersection with sphere and all planes */
float isectAll(in vec3 ro, in vec3 rd, out float hitSphere, out float hitPlane, out int hitPlaneID) {
  hitSphere = iSphere(ro, rd, s1.pt);
  hitPlane = isectAllPlanes(ro, rd, hitPlaneID);
  if(hitSphere > 0 && hitPlane > 0) return min(hitSphere, hitPlane);
  if(hitPlane > 0) return hitPlane;
  return -1;
}

/***************** BASIC LIGHTING *****************/
/* Lambertian Diffuse & Phong Specularity lighting calculations */
float diffuseAmt(in vec3 pt, in vec3 norm) {
  return dot(norm, normalize(litPos - pt));
}
float phongAmt(in vec3 pt, in vec3 dir, in vec3 norm, in float shiny) {
  vec3 ref = reflect(normalize(dir), norm);
  return pow(max(0,dot(ref, normalize(litPos - pt))), shiny);
}

void main() {
  /* Variable geometry setup */
  planes[0] = Plane(vec3( 0, 0,-20), vec3( 0, 0, 1), vec3(0.3,0.3,0.3));
  planes[1] = Plane(vec3( 0,-2, 0), vec3( 0, 1, 0), vec3(0.9,0.5,0.5));
  planes[2] = Plane(vec3(-2, 0, 0), vec3( 1, 0, 0), vec3(0.6,0.9,0.1));
  planes[3] = Plane(vec3( 0, 0, 6), vec3( 0, 0,-1), vec3(0.2,0.2,0.4));
  planes[4] = Plane(vec3( 0, 2, 0), vec3( 0,-1, 0), vec3(0.9,0.5,0.5));
  planes[5] = Plane(vec3( 2, 0, 0), vec3(-1, 0, 0), vec3(0.6,0.9,0.1));

  s1 = Sphere(vec4(0,0,-15,1), vec3(0.9,0.6,0.2));

  /* Ray initialization */
  vec2 uv = vertTexCoord.xy;
  vec3 ro = camPos;
  vec3 pixPt = vec3(-1 + 2*uv, 0);
  vec3 rd = normalize(pixPt - ro);

  /* Find closest sphere and plane hits */
  float hitSphere, hitPlane;
  int hitPlaneID;
  isectAll(ro, rd, hitSphere, hitPlane, hitPlaneID);

  /* Find the hit point, normal, and base color */
  vec3 hitPt, hitNorm, hitCol;
  //If the sphere is closest
  if (hitSphere > 0.0 && hitSphere < hitPlane) {
    hitPt = ro + hitSphere * rd;
    hitNorm = nSphere(hitPt, s1.pt);
    hitCol = texture2D(sphTex, uvSphere(hitPt, s1.pt)).xyz;
  } else { //Otherwise, a plane is closest
    hitPt = ro + hitPlane * rd;
    hitNorm = planes[hitPlaneID].norm;
    hitCol = planes[hitPlaneID].col;
  }

  float dif = diffuseAmt(hitPt, hitNorm);
  float phg = phongAmt(hitPt, rd, hitNorm, 10);

  vec3 col = dif * hitCol + phg * vec3(0.5);
  //col = vec3(1+hitPlaneID) / 7;

  /* Determine if there's an object in between hit and light */
  vec3 toLight = normalize(litPos - hitPt);
  float closestT = isectAll(hitPt + EPSILON * toLight, toLight, hitSphere, hitPlane, hitPlaneID);
  if(closestT < distance(hitPt, litPos)) {
    col = vec3(0); //Become black if in shadow
  }

  gl_FragColor = vec4(col, 1.0);
}

