#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

uniform float fraction;

varying vec4 vertColor;
varying vec3 lightDir;
varying vec3 ecNormal;

void main() {  
  vec3 direction = normalize(lightDir);
  vec3 normal = normalize(ecNormal);
  float intensity = max(0.0, dot(direction, normal));
  
  vec4 color;
  if (intensity > pow(0.95, fraction)) {
    color = vec4(vec3(1.0), 1.0);
  } else if (intensity > pow(0.5, fraction)) {
    color = vec4(vec3(0.8), 1.0);
  } else if (intensity > pow(0.25, fraction)) {
    color = vec4(vec3(0.6), 1.0);
  } else {
    color = vec4(vec3(0.4), 1.0);
  }
  //color = vec4(vec3(intensity), 1.0);

  gl_FragColor = color * vertColor;  
}
