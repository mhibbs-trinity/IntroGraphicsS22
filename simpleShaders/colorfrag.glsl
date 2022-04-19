#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_COLOR_SHADER

varying vec4 vertColor;

void main() {
  gl_FragColor = vec4(vec3(0.5), 1.0);
}