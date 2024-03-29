#define PROCESSING_POINT_SHADER

uniform mat4 projection;
uniform mat4 modelview;

uniform float weight;

attribute vec4 vertex;
attribute vec4 color;
attribute vec2 offset;

varying vec4 vertColor;
varying vec2 texCoord;
varying vec4 eyePos;

void main() {
  eyePos = modelview * vertex;
  vec4 clip = projection * eyePos;

  gl_Position = clip + projection * vec4(offset, 0, 0);
  
  texCoord = (vec2(0.5) + offset / weight);

  vertColor = color;
}
