enum Mode { FACE, VERTEX, DEFAULT }
Mode mode = Mode.DEFAULT;

void setup() {
  size(500,500,P3D);
}

int zplane = 0;
float lightX = -150;
float lightY = -150;
float lightZ = 200;

float rotY = 0f;

void draw() {
  background(0);
  translate(200,200, zplane);
  rotateY(rotY);
   
  lightX = mouseX - 200;
  lightY = mouseY - 200;
  pointLight(255,255,255, lightX,lightY,lightZ);
  stroke(255);
  strokeWeight(10);
  point(lightX,lightY,lightZ); 
  
  ambientLight(50,0,0);
  
  //Axes
  noFill();
  strokeWeight(1);
  stroke(color(255,0,0));
  line(-width,0,0, width,0,0);
  stroke(color(0,255,0));
  line(0,-height,0, 0,height,0);
  stroke(color(0,0,255));
  line(0,0,width, 0,0,-width);
  
  noStroke();
  fill(128);
  
  PVector a = new PVector(0,0,0);
  PVector b = new PVector(100,0,-100);
  PVector c = new PVector(0,100,-100);
  PVector d = new PVector(-100,0,-100);
  PVector e = new PVector(0,-100,-100);
  
  PVector ABCnorm = PVector.sub(c,a);
  ABCnorm = ABCnorm.cross(PVector.sub(b,a));
  ABCnorm.normalize();
  
  PVector ACDnorm = PVector.sub(a,c);
  ACDnorm = ACDnorm.cross(PVector.sub(c,d));
  ACDnorm.normalize();
  
  PVector ADEnorm = PVector.sub(a,d);
  ADEnorm = ADEnorm.cross(PVector.sub(d,e));
  ADEnorm.normalize();
  
  PVector AEBnorm = PVector.sub(a,e);
  AEBnorm = AEBnorm.cross(PVector.sub(e,b));
  AEBnorm.normalize();
  
  if(mode == Mode.FACE) {
    beginShape(TRIANGLES);
    
    normal(ABCnorm.x,ABCnorm.y,ABCnorm.z);
    vertex(a.x,a.y,a.z);
    vertex(b.x,b.y,b.z);
    vertex(c.x,c.y,c.z);
    
    normal(ACDnorm.x,ACDnorm.y,ACDnorm.z);
    vertex(a.x,a.y,a.z);
    vertex(c.x,c.y,c.z);
    vertex(d.x,d.y,d.z);
    
    normal(ADEnorm.x,ADEnorm.y,ADEnorm.z);
    vertex(a.x,a.y,a.z);
    vertex(d.x,d.y,d.z);
    vertex(e.x,e.y,e.z);
    
    normal(AEBnorm.x,AEBnorm.y,AEBnorm.z);
    vertex(a.x,a.y,a.z);
    vertex(e.x,e.y,e.z);
    vertex(b.x,b.y,b.z);
    endShape();
  }
  
  //Begin per-vertex normals
  if(mode == Mode.VERTEX) {
    //DIY per-vetex normals
    PVector anorm = new PVector(0,0,1);
    PVector bnorm = PVector.add(ABCnorm,AEBnorm); 
    bnorm.normalize();
    PVector cnorm = PVector.add(ABCnorm,ACDnorm);
    cnorm.normalize();
    PVector dnorm = PVector.add(ACDnorm,ADEnorm);
    dnorm.normalize();
    PVector enorm = PVector.add(ADEnorm,AEBnorm);
    enorm.normalize();
    
    beginShape(TRIANGLES);
    vertNormal(a,anorm);
    vertNormal(b,bnorm);
    vertNormal(c,cnorm);
    
    vertNormal(a,anorm);
    vertNormal(c,cnorm);
    vertNormal(d,dnorm);
    
    vertNormal(a,anorm);
    vertNormal(d,dnorm);
    vertNormal(e,enorm);
    
    vertNormal(a,anorm);
    vertNormal(e,enorm);
    vertNormal(b,bnorm);
    endShape();
  }
  
  //Processing's built in per-vertex normals
  if(mode == Mode.DEFAULT) {
    beginShape(TRIANGLE_FAN);
    vertex(a.x,a.y,a.z);
    vertex(b.x,b.y,b.z);
    vertex(c.x,c.y,c.z);
    vertex(d.x,d.y,d.z);
    vertex(e.x,e.y,e.z);
    vertex(b.x,b.y,b.z);
    endShape();
  }
  
}

void vertNormal(PVector v, PVector n) {
  normal(n.x, n.y, n.z);
  vertex(v.x, v.y, v.z);
}

void keyPressed() {
  if(keyCode == UP) zplane += 5;
  if(keyCode == DOWN) zplane -= 5;
  if(key == 'f') mode = Mode.FACE;
  if(key == 'v') mode = Mode.VERTEX;
  if(key == 'd') mode = Mode.DEFAULT;
}
