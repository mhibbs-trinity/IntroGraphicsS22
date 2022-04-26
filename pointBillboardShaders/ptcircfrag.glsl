#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
#define PROCESSING_POINT_SHADER

//uniform sampler2D sprite;

varying vec4 vertColor;
varying vec2 texCoord;

void main() {
  float d = distance(texCoord, vec2(0.5,0.5));
  
  if(d > 0.5 || d < 0.45) discard;

  gl_FragColor = vec4(1.0, 1.0, 0.0, 1.0);
}