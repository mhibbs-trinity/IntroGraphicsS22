PShader shade;

void setup() {
  size(500,500, P3D);
  
  shade = loadShader("colorfrag.glsl", "colorvert.glsl");
}

void draw() {
  shader(shade);
  
  background(0);
  
  translate(width/2,height/2);
  fill(map(mouseX,0,width,0,255), map(mouseY,0,height,0,255), 100);
  //sphere(200);
  
  beginShape();
    fill(255,0,0);
    vertex(-100,100,0);
    fill(0,255,0);
    vertex(100,100,0);
    fill(0,0,255);
    vertex(0,-300,0);
  endShape(CLOSE);
  
  
}
