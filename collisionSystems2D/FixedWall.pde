class FixedWall {
  PVector end1;
  PVector end2;
 
  public FixedWall(PVector _end1, PVector _end2) {
    end1 = _end1.copy();
    end2 = _end2.copy();
  }
 
  void display() {
    stroke(0);
    strokeWeight(2);
    line(end1.x,end1.y, end2.x,end2.y);
  } 
}
