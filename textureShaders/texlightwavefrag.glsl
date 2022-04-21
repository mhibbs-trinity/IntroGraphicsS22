#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
#define PROCESSING_TEXLIGHT_SHADER

varying vec4 vertColor;
varying vec3 ecNormal;
varying vec3 hVector;
varying vec3 lightDir;

void main() {
  vec3 direction = normalize(lightDir);
  vec3 normal = normalize(ecNormal);
  vec3 h = normalize(hVector);
  float intensity = max(0.0, dot(direction, normal));
  float specular = pow(dot(h, normal), 1000.0);
  vec4 texCol = vertColor;
  gl_FragColor = vec4(vec3(intensity), 1.0)*texCol + vec4(vec3(specular),1.0)*vertColor;
}
