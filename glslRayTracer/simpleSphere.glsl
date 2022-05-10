#define PROCESSING_TEXTURE_SHADER
#define PI 3.1415926535897932384626433832795

uniform sampler2D sphTex;

varying vec4 vertTexCoord;

struct Sphere {
  vec4 pt; //xyz is center point; w is radius
  vec3 col;
};

Sphere s1 = Sphere(vec4(0,0,-1,1), vec3(0.9,0.6,0.2));
vec3 litPos = vec3(-3,-3,1);

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
vec2 uvSphere(in vec3 pos, in vec4 sph) {
  vec3 norm = nSphere(pos, sph);
  float v = (asin(norm.y) + PI/2) / PI;
  float u = (atan(norm.x, norm.z) + PI) / (2 * PI);
  return vec2(u,v);
}

float diffuseAmt(in vec3 pt, in vec3 norm) {
  return dot(norm, normalize(litPos - pt));
}
float phongAmt(in vec3 pt, in vec3 dir, in vec3 norm, in float shiny) {
  vec3 ref = reflect(normalize(dir), norm);
  return pow(max(0,dot(ref, normalize(litPos - pt))), shiny);
}

void main() {
  vec2 uv = vertTexCoord.xy;
  vec3 ro = vec3(0,0,4);
  vec3 pixPt = vec3(-1 + 2*uv, 0);
  vec3 rd = normalize(pixPt - ro);

  float hit = iSphere(ro, rd, s1.pt);
  if(hit < 0) discard;
  vec3 hitPt = ro + hit * rd;
  vec3 hitNorm = nSphere(hitPt, s1.pt);

  float dif = diffuseAmt(hitPt, hitNorm);
  float phg = phongAmt(hitPt, rd, hitNorm, 10);

  vec4 texCol = texture2D(sphTex, uvSphere(hitPt, s1.pt));
  //vec3 col = dif * texCol.xyz + phg * vec3(0.5);
  //vec3 col = dif * s1.col + phg * vec3(0.5);
  vec3 col = dif * vec3(1, uv.x, uv.y) + phg * vec3(0.5);
  gl_FragColor = vec4(col, 1.0);
}

