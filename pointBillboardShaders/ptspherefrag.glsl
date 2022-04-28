#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
#define PROCESSING_POINT_SHADER

//uniform sampler2D sprite;
uniform mat4 projection;
uniform mat4 modelview;
uniform mat3 normalMatrix;

uniform float weight;

varying vec4 vertColor;
varying vec2 texCoord;
varying vec3 lightDir;
varying vec4 eyePos;

void main() {
  vec2 pos = texCoord - vec2(0.5,0.5);

  if(length(pos) > 0.5) discard;

  float r = 0.5;
  float x = pos.x;
  float y = pos.y;
  float z = sqrt(r*r - x*x - y*y);

  vec3 normal = normalize(vec3(x,y,z));
  vec3 litDir = normalize(lightDir);
  float intense = max(0.0, dot(normal, litDir));

  //gl_FragColor = vec4(litDir,1.0);
  gl_FragColor = vec4(normal, 1.0);
  //gl_FragColor = vec4(vec3(intense),1.0) * vertColor;

  vec4 dpos = eyePos;
  dpos.z += z*weight;
  dpos = projection * dpos;
  gl_FragDepth = (dpos.z / dpos.w + 1.0) / 2.0;
}
