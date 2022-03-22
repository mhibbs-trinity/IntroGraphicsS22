PImage img;

DragCircle a = new DragCircle(100, 100, 10);
DragCircle b = new DragCircle(400, 100, 10);
DragCircle c = new DragCircle(400, 400, 10);
DragCircle d = new DragCircle(100, 400, 10);

void setup() {
  size(500, 500, P2D);
  img = loadImage("SundayInPark.jpg");
}

void draw() {
  background(0);
  beginShape();
  texture(img);

  textureMode(NORMAL);
  vertex(a.x, a.y, 0, 0);
  vertex(b.x, b.y, 1, 0);
  vertex(c.x, c.y, 0.75, 0.75);
  vertex(d.x, d.y, 0, 1);

  endShape();
  a.display();
  b.display();
  c.display();
  d.display();
}
