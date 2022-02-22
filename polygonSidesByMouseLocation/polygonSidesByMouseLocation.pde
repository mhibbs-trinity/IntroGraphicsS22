void setup() {
  size(600,600);
  
}

void draw() {
  background(color(0));
  stroke(color(255));
  
  float r = 200;
  float step = map(mouseX, 0,width, PI, PI/128);
  fill(color(200,50,30));
  textSize(32);
  text(str(step), 50,40);
  
  stroke(color(255));
  strokeWeight(10);
  beginShape();
  for(float theta = 0; theta <= PI*2; theta += step) {
    vertex(300+r*cos(theta),300+r*sin(theta));
  }
  endShape(CLOSE);
}
