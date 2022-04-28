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
  gl_FragColor = vertColor;
}
