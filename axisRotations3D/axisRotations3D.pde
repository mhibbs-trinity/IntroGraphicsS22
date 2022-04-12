

void setup() {
  size(500,500,P3D);
  translate(width/2,height/2, 0);
  rotateY(PI/6);
  rotateX(-PI/6);
  pushMatrix();
}

void draw() {
  popMatrix();
  lights();
  background(0);
  
   
  float lightX = mouseX - width/2;
  float lightY = mouseY - height/2;
  float lightZ = 400;
  pointLight(255,255,255, lightX,lightY,lightZ);
  stroke(255);
  strokeWeight(10);
  point(lightX,lightY,lightZ); 
  
  ambientLight(50,0,0);
  
  //Axes
  noFill();
  strokeWeight(5);
  stroke(color(255,0,0));
  line(-width,0,0, width,0,0);
  stroke(color(0,255,0));
  line(0,-height,0, 0,height,0);
  stroke(color(0,0,255));
  line(0,0,width, 0,0,-width);

  fill(255);
  noStroke();
  sphere(100);
  
  pushMatrix();
}
