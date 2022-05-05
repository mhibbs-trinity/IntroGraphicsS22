#ifdef GL_ES
precision highp float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform float time;
uniform float litOffX;
uniform float litOffY;
uniform float litOffZ;
uniform float camOffX;
uniform float camOffY;
uniform float camOffZ;

varying vec4 vertColor;
varying vec4 vertTexCoord;

struct Plane {
	vec3 pt;
	vec3 norm;
	vec3 color;
	float diffuse;
	float specular;
};
int numPlanes = 6;
Plane planes[6];

struct Sphere {
	vec4 pt;
	vec3 color;
	float diffuse;
	float specular;
};
int numSpheres = 3;
Sphere spheres[3];

vec3 light = vec3(-3.0, -3.0, 1.0);
vec3 ambient = vec3(0.2, 0.2, 0.2);


float iSphere(in vec3 ro, in vec3 rd, in vec4 sph) {
	//sphere at origin has eqn |xyz| = r
	// so |xyz|^2 = r^2, or <xyz,xyz> = r^2
	// xyz = ro + t*rd, so |ro|^2 + t^2 + 2t<ro,rd> - r^2 = 0
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

void intersect(in vec3 ro, in vec3 rd,
               out float tplane, out int planeid,
			   out float tsphere, out int sphereid) {
	tplane = 1000.0;
	planeid = -1;
	for(int i=0; i<numPlanes; i++) {
		float tp = iPlane(ro, rd, planes[i].pt, planes[i].norm);
		if(tp > 0.0 && tp < tplane) {
			tplane = tp;
			planeid = i;
		}
	}
	
	tsphere = 1000.0;
	sphereid = -1;
	for(int i=0; i<numSpheres; i++) {
		float ts = iSphere(ro, rd, spheres[i].pt);
		if(ts > 0.0 && ts < tsphere) {
			tsphere = ts;
			sphereid = i;
		}
	}
}

float shadowCast(in vec3 pos) {
	vec3 toLight = light - pos;
	float lightDist = length(toLight);
	toLight = normalize(toLight);
	vec3 npos = pos + 0.001*toLight;
	float tp, ts;
	int pid, sid;
	intersect(npos, toLight, tp, pid, ts, sid);
	if(lightDist > tp || lightDist > ts)
		return 0.0;
	else
		return 1.0;
}

vec3 diffuseColSphere(in vec3 ro, in vec3 rd, in float t, in int sid) {
	vec3 pos = ro + t*rd;
	vec3 nor = nSphere(pos, spheres[sid].pt);
	float dif = dot(nor, normalize(light-pos));
	return spheres[sid].color*spheres[sid].diffuse*dif;
}

vec3 diffuseColPlane(in vec3 ro, in vec3 rd, in float t, in int pid) {
	vec3 pos = ro + t*rd;
	vec3 toLight = normalize(light-pos);
	float dif = clamp(dot(planes[pid].norm, toLight), 0.0, 1.0);
	return planes[pid].color*planes[pid].diffuse*dif;
}

vec3 specularColor(in vec3 pos, in vec3 dir, in vec3 norm) {
	vec3 specCol = vec3(0.0);
	vec3 ref = reflect(normalize(dir), norm);
	float rtp, rts;
	int rpid, rsid;
	intersect(pos + 0.001*ref, ref, rtp, rpid, rts, rsid);
	if(rpid >= 0) {
		if(rsid >= 0) {
			if(rtp < rts) specCol = diffuseColPlane(pos, ref, rtp, rpid);
			else specCol = diffuseColSphere(pos, ref, rts, rsid);
		} else specCol = diffuseColPlane(pos, ref, rtp, rpid);
	} else if(rsid >= 0) specCol = diffuseColSphere(pos, ref, rts, rsid);
	return specCol;
}

vec3 colSphere(in vec3 ro, in vec3 rd, in float t, in int sid) {
	vec3 dif = diffuseColSphere(ro, rd, t, sid);
	
	vec3 pos = ro + t*rd;
	vec3 nor = nSphere(pos, spheres[sid].pt);
	vec3 specCol = vec3(0.0);
	if(spheres[sid].specular > 0.0) specCol = specularColor(pos, rd, nor);
	
	return (dif + specCol*spheres[sid].specular)*shadowCast(pos) +
	        spheres[sid].color*ambient;
}


vec3 colPlane(in vec3 ro, in vec3 rd, in float t, in int pid) {
	vec3 dif = diffuseColPlane(ro, rd, t, pid);
	
	vec3 pos = ro + t*rd;
	vec3 specCol = vec3(0.0);
	if(planes[pid].specular > 0.0) specCol = specularColor(pos, rd, planes[pid].norm);
	
	return (dif + specCol*planes[pid].specular)*shadowCast(pos) +
	        planes[pid].color*ambient;
}

void main() {
	//light.x = 3.0*sin(time);
	//light.y = 3.0*cos(time);
	light.x += litOffX;
	light.y += litOffY;
	light.z += litOffZ;

	planes[0] = Plane(vec3( 4.0, 0.0, 0.0), vec3(-1.0, 0.0, 0.0), vec3(0.8,0.0,0.0), 1.0, 0.0);
	planes[1] = Plane(vec3(-4.0, 0.0, 0.0), vec3( 1.0, 0.0, 0.0), vec3(0.0,0.8,0.0), 1.0, 0.0);
	planes[2] = Plane(vec3( 0.0, 4.0, 0.0), vec3( 0.0,-1.0, 0.0), vec3(0.0,0.0,0.8), 0.0, 1.0);
	planes[3] = Plane(vec3( 0.0,-4.0, 0.0), vec3( 0.0, 1.0, 0.0), vec3(0.8,0.8,0.0), 1.0, 0.0);
	planes[4] = Plane(vec3( 0.0, 0.0, 4.0), vec3( 0.0, 0.0,-1.0), vec3(0.8,0.0,0.8), 1.0, 0.0);
	planes[5] = Plane(vec3( 0.0, 0.0,-4.0), vec3( 0.0, 0.0, 1.0), vec3(0.0,0.8,0.8), 1.0, 0.0);
	spheres[0] = Sphere(vec4(-2.0, -2.0, -3.0, 1.0), vec3(0.5,0.5,0.5), 1.0, 0.0);
	spheres[1] = Sphere(vec4(-2.0,  3.0, -3.0, 1.0), vec3(0.5,0.5,0.0), 1.0, 0.0);
	//spheres[2] = Sphere(vec4( 2.5,  2.5, -2.5, 1.5), vec3(0.5,0.5,0.5), 0.0, 1.0);
	spheres[2] = Sphere(vec4( 2.0,  2.0, -2.0, 2.0), vec3(0.5,0.5,0.5), 0.0, 1.0);

	//pixel coordinates from 0 to 1
	vec2 uv = vertTexCoord.xy;
	
	//generate ray from ro in direction rd
	vec3 ro = vec3(0.0, 0.0, 3.9);
	ro.x += camOffX;
	ro.y += camOffY;	
	ro.z += camOffZ;
		
	vec3 rd = normalize(vec3(-1.0+2.0*uv, -1.0));
	
	//intersect ray with scene
	float tplane, tsphere;
	int planeid, sphereid;
	intersect(ro,rd, tplane,planeid,tsphere,sphereid);
	
	vec3 col = vec3(0.0);
	if(planeid >= 0) {
		if(sphereid >= 0) {
			if(tplane < tsphere) {
				col = planes[planeid].color;
				col = colPlane(ro, rd, tplane, planeid);
			} else {
				col = spheres[sphereid].color;
				col = colSphere(ro, rd, tsphere, sphereid);
			}
		} else {
			col = planes[planeid].color;
			col = colPlane(ro, rd, tplane, planeid);
		}
	} else if(sphereid >= 0) {
		col = spheres[sphereid].color;
		col = colSphere(ro, rd, tsphere, sphereid);
	}
	
	gl_FragColor = vec4(col,1.0);
}