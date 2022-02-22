class RunSquare {
  float x,y,d;
  float origX,origY;
  float destX,destY;
  boolean moving = false;
  float moveIncr = 0.01;
  float moveFraction = 0;
  
  RunSquare(float _x, float _y, float _d) {
    x = _x; y = _y; d = _d;
    origX = x; origY = y;
    destX = x; destY = y;
  }
  void moveTo(float dx, float dy) {
    origX = x;
    origY = y;
    destX = dx;
    destY = dy;
    moving = true;
    moveFraction = 0;
    moveIncr = 0.01;
  }
  void moveTo(float dx, float dy, float speed) {
    origX = x;
    origY = y;
    destX = dx;
    destY = dy;
    moving = true;
    moveFraction = 0;
    moveIncr = 1f / (dist(x,y, dx,dy)/speed);
  }
  void display() {
    if(moving) {
      moveFraction += moveIncr;
      x = lerp(origX, destX, moveFraction);
      y = lerp(origY, destY, moveFraction);
      fill(50,200,50);
      noStroke();
      ellipse(destX,destY,5,5);
      if(moveFraction >= 1) {
        moving = false;
      }
    }
    rectMode(CENTER);
    stroke(255);
    fill(200);
    rect(x,y,d,d);
  }
}

void setup() {
  size(600,600);
}

RunSquare square = new RunSquare(300,300,100);

void draw() {
  background(0);
  square.display();
}

void mouseClicked() {
  square.moveTo(mouseX,mouseY, 4);
}
