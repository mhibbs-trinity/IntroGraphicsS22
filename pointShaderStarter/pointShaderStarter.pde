PShader pointShade;
PImage img;
ArrayList<PVector> pts;

float weight = 100;
float rot = 0;

void setup() {
  size(500,500,P3D);
  img = loadImage("tree1.png");
  //img = loadImage("cloud1.png");
  //img = loadImage("billboard.jpg");
  
  pts = new ArrayList<PVector>();
  pointShade = loadShader("ptfrag.glsl","ptvert.glsl");
  
  pointShade.set("weight", weight);
  pointShade.set("sprite", img);
}

void draw() {
  background(128);
  shader(pointShade, POINTS);
  
  pointShade.set("litPos",new PVector((mouseX-width/2)*3,(mouseY-height/2)*3,600));
  
  translate(width/2,height/2);
  rotateX(rot);
  translate(-width/2,-height/2);
  
  strokeWeight(weight);
  strokeCap(SQUARE);
  stroke(255);

  if(mousePressed && mouseButton == LEFT) {
    if(keyPressed) {
      pts.add(new PVector(mouseX,mouseY, -200));
    } else {
      pts.add(new PVector(mouseX,mouseY,0));
    }
  } 
  for(PVector pt : pts) { point(pt.x,pt.y,pt.z); }
}

void mouseDragged() {
  if(mouseButton == RIGHT) {
    rot += float(mouseY - pmouseY)/width;
  }
}
