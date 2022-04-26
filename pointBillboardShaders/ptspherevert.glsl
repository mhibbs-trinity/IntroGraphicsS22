#define PROCESSING_POINT_SHADER

uniform mat4 projection;
uniform mat4 modelview;

uniform float weight;
uniform vec3 litPos;
 
attribute vec4 vertex;
attribute vec4 color;
attribute vec2 offset;

varying vec4 vertColor;
varying vec2 texCoord;
varying vec3 lightDir;
varying vec4 eyePos;

void main() {
  eyePos = modelview * vertex;
  vec4 offPos = eyePos + modelview * vec4(offset, 0, 0);
  lightDir = normalize((vec4(litPos,1.0) - offPos).xyz);
  
  vec4 clip = projection * eyePos;
  gl_Position = clip + projection * vec4(offset, 0, 0);
  
  texCoord = (vec2(0.5) + offset / weight);
  
  vertColor = color;
}