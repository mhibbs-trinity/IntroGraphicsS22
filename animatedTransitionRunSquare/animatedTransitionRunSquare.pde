
void setup() {
  size(600,600);
}

RunSquare square = new RunSquare(300,300,100);

void draw() {
  background(0);
  square.display();
}

void mouseClicked() {
  //square.moveTo(mouseX,mouseY);
  square.moveTo(mouseX,mouseY, 4);
}
