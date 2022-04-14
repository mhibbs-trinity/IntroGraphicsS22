IcoSphere is;
float phi = (1 + sqrt(5)) / 2;

void setup() {
  size(500,500,P3D);
  is = new IcoSphere();
  
  translate(width/2,height/2);
  
  //scale(200);
  pushMatrix();
}

void draw() {
  popMatrix();
  background(0);
  ambientLight(50,50,50);
  
  pointLight(255,255,255, mouseX*2 - width,mouseY*2 - height,400);
  
  strokeWeight(2);
  stroke(255,0,0);
  line(-width,0,0, width,0,0);
  stroke(0,255,0);
  line(0,-height,0, 0,height,0);
  stroke(0,0,255);
  line(0,0,-width, 0,0,width);
  
  pushMatrix();
  scale(100);
  
  noStroke();
  fill(255,0,0,200);
  beginShape();
  vertex(-phi,-1,0); //0
  vertex( phi,-1,0); //1
  vertex( phi, 1,0); //2
  vertex(-phi, 1,0); //3
  endShape(CLOSE);
  
  fill(0,255,0,200);
  beginShape();
  vertex(0,-phi,-1); //4
  vertex(0,-phi, 1); //5
  vertex(0, phi, 1); //6 
  vertex(0, phi,-1); //7
  endShape(CLOSE);
  
  fill(0,0,255,200);
  beginShape();
  vertex(-1,0,-phi); //8
  vertex( 1,0,-phi); //9
  vertex( 1,0, phi); //10
  vertex(-1,0, phi); //11
  endShape();
  
  scale(phi*1.18);
  
  
  fill(255);
  noStroke();
  if(keyPressed && (key == 'G' || key == 'g')) {
    noFill();
    stroke(255,128);
    strokeWeight(1.0/50);
  }
  is.display();
  
  popMatrix();
  
  if(mousePressed) {
    if(mouseButton == LEFT) rotateY(float(mouseX-pmouseX)/width);
    if(mouseButton == RIGHT) rotateX(float(mouseY-pmouseY)/height);
  }

  pushMatrix();
}

void keyPressed() {
  if(key == ' ') {
    is.subdivideAllTris();
  }
}
