#ifdef GL_ES
precision highp float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform float time;

varying vec4 vertColor;
varying vec4 vertTexCoord;

float iSphere(in vec3 ro, in vec3 rd, in vec4 sph) {
	//sphere at origin has eqn |xyz| = r
	// so |xyz|^2 = r^2, or <xyz,xyz> = r^2
	// xyz = ro + t*rd, so |ro|^2 + t^2 + 2<ro,rd> - r^2 = 0
	vec3 oc = ro - sph.xyz;
	float b = 2.0 * dot(oc,rd);
	float c = dot(oc,oc) - sph.w*sph.w;
	float d = b*b - 4.0*c;
	if(d < 0.0) return -1.0;
	float t = (-b - sqrt(d)) / 2.0;
	return t;
}

vec3 nSphere(in vec3 pos, in vec4 sph) {
	return (pos - sph.xyz) / sph.w;
}

float iPlane(in vec3 ro, in vec3 rd, in vec3 p0, in vec3 norm) {
	//plane eqn: <p-p0,norm> = 0
	//ray eqn: p = ro.y + t*rd.y;
	return dot(p0 - ro, norm) / dot(rd, norm);
}

vec3 nPlane(in vec3 pos) {
	return vec3(0.0, -1.0, 0.0);
}

vec4 sph1 = vec4(0.0, -1.0, 0.0, 1.0);
vec3 p1orig = vec3(0.0, 0.0, 0.0);
vec3 p1norm = vec3(0.0, -1.0, 0.0);
vec3 p2orig = vec3(0.0, 0.0, -20.0);
vec3 p2norm = vec3(0.0, 0.0, 1.0);

int intersect(in vec3 ro, in vec3 rd, out float t) {
	t = 1000.0;
	int id = -1;
	float tsphere = iSphere(ro,rd,sph1);
	float tplane1 = iPlane(ro,rd,p1orig,p1norm);
	float tplane2 = iPlane(ro,rd,p2orig,p2norm);
	if(tsphere > 0.0) {
		t = tsphere;
		id = 1;
	}
	if(tplane1 > 0.0 && tplane1 < t) {
		t = tplane1;
		id = 2;
	}
	if(tplane2 > 0.0 && tplane2 < t) {
		t = tplane2;
		id = 3;
	}
	return id;
}

void main() {
	vec3 light = vec3(-2.0, -4.0, 4.0);
	//pixel coordinates from 0 to 1
	vec2 uv = vertTexCoord.xy;

	sph1.x = 0.5*cos(time);
	sph1.z = 0.5*sin(time);

	//generate ray from ro in direction rd
	vec3 ro = vec3(0.0, -0.5, 4.0);
	vec3 rd = normalize(vec3(-1.0+2.0*uv, -1.0));

	//intersect ray with scene
	float t;
	float id = intersect(ro,rd,t);

	vec3 col = vec3(0.0);
	if(id == 1) {
		vec3 pos = ro + t*rd;
		vec3 nor = nSphere(pos, sph1);
		float dif = dot(nor, normalize(light-pos));
		float amb = 0.2;
		col = vec3(0.0, 0.0, 0.8)*dif + amb*vec3(0.4,0.1,0.1);
	} else if(id == 2) {
		vec3 pos = ro + t*rd;
		vec3 nor = p1norm;

		vec3 toLight = normalize(light - pos);
		float dif = clamp(dot(nor, toLight), 0.0, 1.0);

		float tshadow = iSphere(pos, toLight, sph1);
		if(tshadow > 0.0 && tshadow < length(light-pos)) {
			dif = 0.0;
		}
		col = vec3(1.0, 0.0, 0.0)*dif;

		//float amb = smoothstep(0.0, 2.0*sph1.w, length(pos.xz - sph1.xz));
		//col = vec3(amb);
	} else if (id == 3) {
		vec3 pos = ro + t*rd;
		vec3 nor = p2norm;

		vec3 toLight = normalize(light-pos);
		float dif = clamp(dot(nor,toLight), 0.0, 1.0);
		col = vec3(0.0,1.0,0.0)*dif;
	}

	gl_FragColor = vec4(col,1.0);

	//gl_FragColor = vec4(1.0,0.0,1.0,1.0);
	//gl_FragColor = vec4(vertTexCoord.x, vertTexCoord.y, 0.0, 1.0);
  //gl_FragColor = texture2D(texture, vertTexCoord.st) * vertColor;
}
