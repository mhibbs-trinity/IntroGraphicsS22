

void setup() {
  size(400,400);
  frameRate(10);
}

int xoff = 50;

void draw() {
  background(0);
  //scale(2);
  //translate(xoff,0);
  //rotate(PI/4);
  //scale(2);
  
  applyMatrix(2, 0, 50, 
              0, 2, 0);
  
  //rotate(PI/4);
  //translate(xoff,0);
  
  //xoff++;
  
  axes();
  fill(color(255,0,0,128));
  ellipseMode(CENTER);
  ellipse(50,25, 25,25);
}

void axes() {
  color lblCol = 200;
  color gridCol = color(200,200,200,128);
  stroke(200);
  strokeWeight(2);
  line(-width,0, +width,0);
  line(0,-height, 0,+height);
  stroke(color(200,128));
  strokeWeight(1);
  for(int i=-width; i<width; i+=25) {
    line(i,-height, i,+height);
    line(-width,i, +width,i);
  }
}
