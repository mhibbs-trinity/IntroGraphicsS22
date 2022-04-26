#define PROCESSING_POINT_SHADER

uniform mat4 projection;

varying vec4 vertColor;
varying vec2 texCoord;

void main() {
  gl_FragColor = vertColor;
}
