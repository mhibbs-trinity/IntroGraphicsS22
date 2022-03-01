DragCircle p1 = new DragCircle(100,100,10);
DragCircle p2 = new DragCircle(200,150,10);
DragCircle p3 = new DragCircle(400,400,10);

color control = color(150,0,0);

DragCircle c1 = new DragCircle(150,100,10, control,color(220,0,0));
DragCircle c2 = new DragCircle(150,175,10, control,color(220,0,0));
DragCircle c3 = new DragCircle(255,125,10, control,color(220,0,0));
DragCircle c4 = new DragCircle(400,300,10, control,color(220,0,0));

void setup() {
  size(600,600);
}

void draw() {
  background(0);
  
  p1.display();
  text("p1",p1.x-5,p1.y-10);
  p2.display();
  text("p2",p2.x-5,p2.y-10);
  p3.display();
  text("p3",p3.x-5,p3.y-10);
  c1.display();
  text("c1",c1.x-5,c1.y-10);
  c2.display();
  text("c2",c2.x-5,c2.y-10);
  c3.display();
  text("c3",c3.x-5,c3.y-10);
  c4.display();
  text("c4",c4.x-5,c4.y-10);
  
  stroke(control);
  line(p1.x,p1.y, c1.x,c1.y);
  line(p2.x,p2.y, c2.x,c2.y);
  line(p2.x,p2.y, c3.x,c3.y);
  line(p3.x,p3.y, c4.x,c4.y);
  
  noFill();
  stroke(255);
  beginShape();
    vertex(p1.x, p1.y);
    bezierVertex(c1.x,c1.y, c2.x,c2.y, p2.x,p2.y);
    bezierVertex(c3.x,c3.y, c4.x,c4.y, p3.x,p3.y);
  endShape();
}
