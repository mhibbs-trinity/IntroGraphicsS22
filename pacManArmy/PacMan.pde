class PacMan {
  float opening;
  float step = PI/64;
  
  PacMan() {
    opening = PI/8;
  }
  PacMan(float initOpen) {
    opening = initOpen;
  }
  
  void display() {
    noStroke();
    fill(200,200,20);
    ellipseMode(CENTER);
    arc(0,0, 50,50, opening,2*PI-opening, PIE);
    opening -= step;
    if(opening <= 0 || opening >= PI/8) {
      step *= -1;
    }
  }
}
