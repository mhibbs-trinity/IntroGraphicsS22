#define PROCESSING_POINT_SHADER

uniform sampler2D sprite;
uniform mat4 projection;

varying vec4 vertColor;
varying vec2 texCoord;

void main() {
  //gl_FragColor = vertColor;
  gl_FragColor = texture2D(sprite, texCoord) * vertColor;
}
