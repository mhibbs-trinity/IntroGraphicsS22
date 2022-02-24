float r = 200;

void setup() {
  size(500,500);
}

void draw() {
  translate(width/2,height/2);
  for(int x=-width/2; x<width/2; x++) {
    for(int y=-height/2; y<height/2; y++) {
      float impl = x*x + y*y - r*r;
      //println(impl);
      if(-500 <= impl && impl <= 500) {
        stroke(255);
        point(x,y);
      } else {
        stroke(0);
        point(x,y);
      }
    }
  }
}
    
