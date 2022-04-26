#define PROCESSING_TEXLIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;
uniform mat4 texMatrix;

uniform vec4 lightPosition;

uniform sampler2D htmap;
uniform float scale;

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

varying vec4 vertColor;
varying vec4 vertTexCoord;
varying mat3 normMat;
//varying vec3 ecNormal;
varying vec3 lightDir;

void main() {
  vertTexCoord = texMatrix * vec4(texCoord, 1.0, 1.0);
  vec4 htCol = texture2D(htmap, vertTexCoord.st);
  float ht = (htCol.x + htCol.y + htCol.z) / 3.0 * scale;
  
  /*mat4 trans = mat4(1.0, 0.0, 0.0, 0.0,
                    0.0, 1.0, 0.0, 0.0,
                    0.0, 0.0, 1.0, -ht,
                    0.0, 0.0, 0.0, 1.0);
  */
  vec4 offVert = vertex + vec4(normal*ht,1.0);

  gl_Position = transform * offVert;
  vec3 ecVertex = vec3(modelview * offVert);  
  normMat = normalMatrix;

  lightDir = normalize(lightPosition.xyz - ecVertex);
  vertColor = color;
}