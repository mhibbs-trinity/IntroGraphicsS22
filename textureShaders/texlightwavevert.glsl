#define PROCESSING_TEXLIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec3 cameraPosition;
uniform vec4 lightPosition;

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

varying vec4 vertColor;
varying vec3 ecNormal;
varying vec3 hVector;
varying vec3 lightDir;

void main() {
  
  vec3 ecVertex = vec3(modelview * vertex);
  vec3 toEye = normalize(cameraPosition - ecVertex);

  ecNormal = normalize(normalMatrix * normal);
  
  gl_Position = transform * vertex + vec4((texCoord.x * ecNormal),0.0);
  
  lightDir = normalize(lightPosition.xyz - ecVertex);  

  hVector = normalize(lightDir + toEye);
  vertColor = color;
}
