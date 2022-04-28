#define PROCESSING_POINT_SHADER

uniform sampler2D sprite;
uniform mat4 projection;

varying vec4 vertColor;
varying vec2 texCoord;
varying vec4 eyePos;

void main() {
  //gl_FragColor = vertColor;
  vec4 texCol = texture2D(sprite, texCoord) * vertColor;
  if(texCol.w < 0.5) discard;

  gl_FragColor = texCol;
  vec4 dpos = projection * eyePos;
  gl_FragDepth = (dpos.z / dpos.w + 1.0) / 2.0;
}
