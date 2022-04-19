#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

varying vec4 vertColor;

void main() {  
  gl_FragColor = vertColor;
}