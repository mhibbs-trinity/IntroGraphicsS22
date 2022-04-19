
float small, mid, heavy;

void setup() {
  size(800,800);
  small = 1 / (width/4/PI);
  mid = small * 2;
  heavy = mid * 2;
}

void draw() {
  background(255);
  translate(width/2,height/2);
  scale(width/(4*PI));
  strokeWeight(small);
  gridLines();
  
  strokeWeight(heavy);
  
  stroke(255,0,0);
  beginShape(POINTS);
  for(float x=-TWO_PI; x<TWO_PI; x+= PI/32) {
    vertex(x, sin(x));
  }
  endShape();
  
  stroke(0,255,0);
  beginShape(POINTS);
  for(float y=-1; y<1; y+=0.1) {
    vertex(asin(y), y);
  }
  endShape();
  
   
}



void gridLines() {
  stroke(100);
  for(float x=-TWO_PI; x<TWO_PI; x+=PI/8) {
    if(abs(x) <= PI/256) strokeWeight(mid);
    else strokeWeight(small);
    line(x,-PI, x,PI);
  }
  for(float y=-2; y<2; y+=0.25) {
    if(abs(y) <= PI/256) strokeWeight(mid);
    else strokeWeight(small);
    line(-TWO_PI,y, TWO_PI,y);
  }
}
