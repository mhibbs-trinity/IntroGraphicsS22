#define PROCESSING_TEXTURE_SHADER
#define PI 3.1415926535897932384626433832795

varying vec4 vertTexCoord;
uniform vec3 litPos;
uniform vec3 camPos;

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

/* Lambertian Diffuse & Phong Specularity lighting calculations */
float diffuseAmt(in vec3 pt, in vec3 norm) {
  return dot(norm, normalize(litPos - pt));
}
float phongAmt(in vec3 pt, in vec3 dir, in vec3 norm, in float shiny) {
  vec3 ref = reflect(normalize(dir), norm);
  return pow(max(0,dot(ref, normalize(litPos - pt))), shiny);
}

void main() {
  planes[0] = Plane(vec3( 0, 0,-20), vec3( 0, 0, 1), vec3(0.3,0.3,0.3));
  planes[1] = Plane(vec3( 0,-2, 0), vec3( 0, 1, 0), vec3(0.9,0.5,0.5));
  planes[2] = Plane(vec3(-2, 0, 0), vec3( 1, 0, 0), vec3(0.6,0.9,0.1));
  planes[3] = Plane(vec3( 0, 0, 6), vec3( 0, 0,-1), vec3(0.2,0.2,0.4));
  planes[4] = Plane(vec3( 0, 2, 0), vec3( 0,-1, 0), vec3(0.9,0.5,0.5));
  planes[5] = Plane(vec3( 2, 0, 0), vec3(-1, 0, 0), vec3(0.6,0.9,0.1));

  vec2 uv = vertTexCoord.xy;
  vec3 ro = camPos;
  vec3 pixPt = vec3(-1 + 2*uv, 0);
  vec3 rd = normalize(pixPt - ro);

  float planeHit = 1000000;
  int planeID = -1;
  for(int i=0; i<numPlanes; i++) {
    float pHit = iPlane(ro, rd, planes[i].pt, planes[i].norm);
    if(pHit > 0 && pHit < planeHit) {
      planeHit = pHit;
      planeID = i;
    }
  }

  vec3 hitPt = ro + planeHit * rd;
  vec3 hitNorm = planes[planeID].norm;

  float dif = diffuseAmt(hitPt, hitNorm);
  float phg = phongAmt(hitPt, rd, hitNorm, 10);

  vec3 rawCol = planes[planeID].col;
  vec3 col = dif * rawCol + phg * vec3(0.5);

  gl_FragColor = vec4(col, 1.0);
}

