#define PROCESSING_TEXTURE_SHADER

varying vec4 vertTexCoord;

void main() {
  gl_FragColor = vec4(vertTexCoord.x, vertTexCoord.y, 0,1);
}

