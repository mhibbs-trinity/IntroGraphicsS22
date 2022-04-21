TextureSphere ts;
float rot = 0;
PImage img;

void setup() {
  size(500,500,P3D);
  //img = loadImage("earth_lights_lrg.jpg");
  //img = loadImage("glass copy.png");
  img = loadImage("jupiter.jpg");
  //img = loadImage("gray.jpg");
  //img = loadImage("grid.png");
  ts = new TextureSphere(180, 100, img);
}

void draw() {
  background(0);
  lightSpecular(200,200,200);
  //pointLight(255,255,255, 0,0,800);
  pointLight(255,255,255, mouseX,mouseY,200);
  strokeWeight(10);
  stroke(255);
  point(mouseX,mouseY,200);
  ambientLight(150,150,150);
  
  noStroke();
  fill(255);
  shininess(map(mouseY, 0,height, 0.01,500));
  
  /*
  translate(100,100);
  rotateY(rot);
  beginShape(QUAD);
  texture(img);
  vertex(0,0,0, 0,0);
  vertex(300,0,0, img.width,0);
  vertex(300,300,0, img.width,img.height);
  vertex(0,300,0, 0,img.height);
  endShape();
  */
  
  //emissive(0,0,50);
  //specular(255,0,0);
  
  translate(250,250);
  //rotateX(-PI/2);
  rotateY(rot);
  ts.display();
  
}

void mouseDragged() {
  float diff = mouseX - pmouseX;
  rot += diff/width;
}
