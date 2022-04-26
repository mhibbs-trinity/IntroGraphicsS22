#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXLIGHT_SHADER

uniform sampler2D texture;
uniform sampler2D normmap;

varying vec4 vertColor;
varying vec4 vertTexCoord;
varying mat3 normMat;
//varying vec3 ecNormal;
varying vec3 lightDir;

void main() {
  vec3 nc = normalize(texture2D(normmap, vertTexCoord.st).xyz);
  vec3 normal = normalize(vec3(nc.x*2.0 - 1.0, nc.y*2.0 - 1.0, nc.z*2.0 - 1.0));
  
  float intensity = max(0.0, dot(lightDir, normal));
  vec4 tintColor = vec4(intensity,intensity,intensity,1.0);
  //gl_FragColor = vec4(nc.x,nc.y,nc.z,1.0);
  gl_FragColor = texture2D(texture, vertTexCoord.st) * tintColor;
}