
PShader bumpy;
PImage colTex;
PImage htTex;
PImage normTex;
float rot;
float dispAmt = 0;

int mode = 0; //Set to 1 for displacement mapping; to 0 for bump mapping

void setup() {
  size(500,500, P3D);
  noStroke();
  //colTex = loadImage("cross_color.jpg");
  //htTex = loadImage("cross_height.jpg");
  //normTex = loadImage("cross_normal.jpg");

  colTex = loadImage("pebble_color.png");
  htTex = loadImage("pebble_height.png");
  normTex = loadImage("pebble_normal.png");

  if(mode == 0) {
    bumpy = loadShader("bumpfrag.glsl", "bumpvert.glsl");
    bumpy.set("normmap", normTex);
  }
  else if(mode == 1) { 
    bumpy = loadShader("dispfrag.glsl", "dispvert.glsl");
    bumpy.set("htmap", htTex);
    bumpy.set("normmap", normTex);
  }
}

void draw() {
  background(0); 
  pointLight(255,255,255, mouseX,mouseY,300);
  stroke(255);
  strokeWeight(5);
  point(mouseX,mouseY,300);
  strokeWeight(1);
  
  translate(width/2,height/2);
  rotateY(rot);
  translate(-width/2,-height/2);
  
  noStroke();
  fill(255);
  shader(bumpy);
  textureMode(NORMAL);
  
  if(keyPressed) {
    if(keyCode == UP) dispAmt += 1.0;
    if(keyCode == DOWN && dispAmt > 0) dispAmt -= 1.0;
  }
  
  if(mode == 1) {
    bumpy.set("scale", dispAmt);
  
    float lo = 50.0;
    float hi = 450.0;
    float diff = hi-lo;
    float segs = 250.0;
    float step = 1.0/segs;
    beginShape(QUADS);
    texture(colTex);
    for(float u=0; u<1.0; u+=step) {
      for(float v=0; v<1.0; v+=step) {
        normal(0,0,1);
        vertex(       lo+u*diff,        lo+v*diff, -100,        u,        v);
        vertex(       lo+u*diff, lo+(v+step)*diff, -100,        u, (v+step));
        vertex(lo+(u+step)*diff, lo+(v+step)*diff, -100, (u+step), (v+step));
        vertex(lo+(u+step)*diff,        lo+v*diff, -100, (u+step),        v);
      }
    }
    endShape();
  }
  else if(mode == 0) {
    beginShape(QUAD);
    texture(colTex);
    normal(0,0,1);
    vertex( 50, 50,0, 0,0);
    vertex( 50,450,0, 0,1);
    vertex(450,450,0, 1,1);
    vertex(450, 50,0, 1,0);
    endShape();
  }
}

void mouseDragged() {
  float diff = mouseX - pmouseX;
  rot += diff/width;
}
