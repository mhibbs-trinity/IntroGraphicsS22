
DragCircle circ = new DragCircle(200,200,100);
DragCircle circ2 = new DragCircle(400,400,50, color(100,0,0),color(200,0,0));

void setup() {
  size(500,500);
}

void draw() {
  background(0);
  circ.display(); 
  circ2.display();
}
