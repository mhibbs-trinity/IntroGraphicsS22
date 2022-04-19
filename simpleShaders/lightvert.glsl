#define PROCESSING_LIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;

void main() {
  gl_Position = transform * vertex;    
  vec3 ecVertex = vec3(modelview * vertex);   
  vec3 ecNormal = normalize(normalMatrix * normal);
  
  vec3 lightDir = normalize(lightPosition.xyz - ecVertex);  
  float intense = max(0.0, dot(lightDir, ecNormal));
  vertColor = vec4(intense, intense, intense, 1.0) * color;
}