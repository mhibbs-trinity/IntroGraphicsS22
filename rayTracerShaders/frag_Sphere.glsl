#define PROCESSING_TEXTURE_SHADER

varying vec4 vertTexCoord;

/* Struct to contain sphere information */
struct Sphere {
	vec4 pt; //(x,y,z) are center; w holds radius
	vec4 color;
	float diffuse;
	float specular;
	float ambient;
};
const int numSpheres = 1;
Sphere spheres[numSpheres];
 
vec3 litPos = vec3(-3, -3, 1);

/* Intersection and normal calculation for a sphere */
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

float diffuseAmt(in vec3 pt, in vec3 norm) {
  return dot(norm, normalize(litPos - pt));
}
float phongAmt(in vec3 pt, in vec3 dir, in vec3 norm, in float shiny) {
  vec3 ref = reflect(normalize(dir), norm);
  return pow(max(0,dot(ref, normalize(litPos - pt))), shiny);
}


void main() {
  spheres[0] = Sphere(vec4(0.0, 0.0, -2.0, 1.0), vec4(0.8,0.5,0.5,1.0), 1,0.5,0.5);

  vec2 uv = vertTexCoord.xy;
  vec3 ro = vec3(0,0,4);
  vec3 imgPlanePt = vec3(-1 + 2*uv, 0);
  vec3 rd = normalize(imgPlanePt - ro);

  float hit = iSphere(ro, rd, spheres[0].pt);
  if(hit < 0) discard;
  vec3 hitPt = ro + hit * rd;
  gl_FragColor = (spheres[0].ambient + diffuseAmt(hitPt, nSphere(hitPt, spheres[0].pt))) * spheres[0].color + phongAmt(hitPt, rd, nSphere(hitPt, spheres[0].pt), 100) * vec4(vec3(spheres[0].specular),1.0);
}
