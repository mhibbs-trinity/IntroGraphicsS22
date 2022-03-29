
void setup() {
  size(600,600, P3D);
}

void draw() {
  background(0);
  
  camera(0,0,map(mouseX, 0,width, 0,width), 0,0,0, 0,1,0);
  
  //translate(300,300);
  //rotateY(map(mouseX, 0,width, 0,TWO_PI));
  //scale(map(mouseY, 0,height, 1,5), 1,1);
  
  stroke(255,0,0);
  line(-width,0,0, width,0,0);
  stroke(0,255,0);
  line(0,-height,0, 0,height,0);
  stroke(0,0,255);
  line(0,0,-width, 0,0,width);
  
  fill(255);
  //rect(0,0, 200,200);
  box(200);
  //sphereDetail(int(map(mouseY, 0,height, 2,64)));
  
  translate(100,100,0);
  sphere(100);
}
