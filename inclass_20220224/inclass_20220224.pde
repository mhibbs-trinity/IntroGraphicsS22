
void setup() {
  size(800,800);
}

void draw() {
  background(0);
  
  float sf = 200f;
  
  stroke(255);
  noFill();
  translate(width/2, height/2);
  scale(sf,sf);
  strokeWeight(1/sf);
  beginShape();
  for(float theta=0; theta<4*PI; theta += PI/32) {
    float x = cos(theta);
    float y = sin(theta) * pow(sin(theta/2), map(mouseX, 0,width, 0,10));
    vertex(x,y);
  }
  endShape();
  
  /*
  stroke(255);
  strokeWeight(5);
  for(float x=-width; x<width; x++) {
    for(float y=-height; y<height; y++) {
      if(abs((x*x + y*y) - (width/2)*(width/2)) < map(mouseX, 0,width, 0,100)) {
        point(x+width/2,y+height/2);
      }
    }
  }
  */
  /*
  translate(0,height/2);
  stroke(255);
  strokeWeight(3);
  //noFill();
  beginShape();
  for(float x=0; x<PI*6; x+=map(mouseY, 0,height, 0.01,1)) {
    vertex(map(x, 0,PI*6, 0,width), height/2 * sin(map(mouseX, 0,width, 0.1,10)*x)); 
  }
  endShape();
  */
  
  
  
}
