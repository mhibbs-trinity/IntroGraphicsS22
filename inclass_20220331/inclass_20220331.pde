
void setup() {
  size(600,600, P3D);
}

void draw() {
  background(0);
  
  
  float theta = PI/2;//map(mouseX, 0,width, 0,TWO_PI);
  //lights();
  
  camera(width * cos(theta),0,width*sin(theta), 0,0,0, 0,1,0);
  //if(keyPressed) {
  //  ortho(-width/2,width/2, -height/2,height/2);
  //}
  //frustum(-width/2,width/2, -height/2,height/2, map(mouseY, 0,height, width/8,width*2),width*2);
 
  pointLight(255,255,255, mouseX,mouseY,width/2);
  strokeWeight(20);
  stroke(255);
  point(mouseX,mouseY,width/2);
  strokeWeight(1);
 
  //translate(0,map(mouseY, 0,height, -300,300),0);
  rotateY(0); 
 
  stroke(255,0,0);
  line(-width,0,0, width,0,0);
  stroke(0,255,0);
  line(0,-height,0, 0,height,0);
  stroke(0,0,255);
  line(0,0,-width, 0,0,width);
  
  fill(255);
  //box(200);
  //translate(100,100,0);
  //sphere(100);
  
  beginShape();
  
  normal(0,0,1);
  vertex(-300,-300,0);
  normal(0,1,0);
  vertex( 300,-300,0);
  normal(1,0,0);
  vertex( 300, 300,0);
  normal(1,0,1);
  vertex(-300, 300,0);
  
  endShape(CLOSE);
  
}
