
#define PROCESSING_COLOR_SHADER

varying vec4 vertColor;

void main() {
  //gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
  gl_FragColor = vertColor;
}
