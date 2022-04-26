#define PROCESSING_POINT_SHADER

uniform mat4 projection;
uniform mat4 modelview;
uniform mat4 transform;

uniform float weight;

attribute vec4 vertex;
attribute vec4 color;
attribute vec2 offset;

varying vec4 vertColor;
varying vec2 texCoord;

void main() {

  vec4 centerPos = transform * vertex;
  //vec4 centerPos = projection * modelview * vertex;
  vec4 posOffset = vec4(offset, 0.0, 0.0);
  gl_Position = centerPos + posOffset;
/*
  vec4 eyePos = modelview * vertex;
  vec4 clip = projection * eyePos;
  gl_Position = clip + projection * vec4(offset, 0, 0);
*/
  vertColor = color;
}
