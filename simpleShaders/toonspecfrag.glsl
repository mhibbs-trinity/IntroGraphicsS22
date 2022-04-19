#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

uniform float fraction;

varying vec4 vertColor;
varying vec3 lightDir;
varying vec3 hVector;
varying vec3 ecNormal;

void main() {  
  vec3 direction = normalize(lightDir);
  vec3 normal = normalize(ecNormal);
  vec3 h = normalize(hVector);
  float intensity = max(0.0, dot(direction, normal));
  
  vec4 diffuseColor;
  if (intensity > pow(0.5, fraction)) {
    diffuseColor = vec4(vec3(0.8), 1.0);
  } else if (intensity > pow(0.25, fraction)) {
    diffuseColor = vec4(vec3(0.6), 1.0);
  } else {
    diffuseColor = vec4(vec3(0.4), 1.0);
  }
  
  float specular = pow(dot(h, normal), 1000.0);
  if(specular > 0.5) specular = 1.0;
  else specular = 0.0;

  gl_FragColor = diffuseColor * vertColor + vec4(vec3(specular),1.0) * vertColor;  
}
