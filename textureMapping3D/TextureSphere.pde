class TextureSphere {
  int nSegs;
  float r;
  PImage img;
  
  TextureSphere(float radius, int numSegments, PImage texture) {
    nSegs = numSegments;
    r = radius;
    img = texture;
  }
  
  void display() {
    beginShape(QUADS);
    texture(img);
    float uStep = 2*PI/nSegs;
    float vStep = PI/nSegs;
    for(float u=0; u<2*PI; u+=uStep) {
      for(float v=-PI/2; v<PI/2; v+=vStep) {
      //for(float v=-200; v<200; v+=vStep) {  
        /*
        vertex(xpos(u,v), ypos(u,v), zpos(u,v), map(u, 0,2*PI, img.width,0), map(v, -PI/2,PI/2, 0,img.height));
        vertex(xpos(u+uStep,v),ypos(u+uStep,v),zpos(u+uStep,v), map(u+uStep, 0,2*PI, img.width,0), map(v, -PI/2,PI/2, 0,img.height));
        vertex(xpos(u+uStep,v+vStep),ypos(u+uStep,v+vStep),zpos(u+uStep,v+vStep), map(u+uStep, 0,2*PI, img.width,0), map(v+vStep, -PI/2,PI/2, 0,img.height));
        vertex(xpos(u,v+vStep),ypos(u,v+vStep),zpos(u,v+vStep), map(u, 0,2*PI, img.width,0), map(v+vStep, -PI/2,PI/2, 0,img.height));
        */
        createVertex(u,v);
        createVertex(u+uStep,v);
        createVertex(u+uStep,v+vStep);
        createVertex(u,v+vStep);
        
      }
    }
    endShape();
  }
  
  void createVertex(float u, float v) {
    float x = xpos(u,v);
    float y = ypos(u,v);
    float z = zpos(u,v);
    PVector norm = new PVector(x,y,z);
    norm.normalize();
    normal(-norm.x,-norm.y,-norm.z);
    strokeWeight(1);
    stroke(map(u,0,2*PI,0,255),map(v,-PI,PI,0,255),0);
    //line(0,0,0, -100*norm.x, -100*norm.y, -100*norm.z);
    noStroke();
    vertex(x,y,z, map(u, 0,2*PI, img.width,0), map(v, -PI/2,PI/2, 0,img.height));
  }
  
  float xpos(float u, float v) {
    return r * sin(u) * cos(v);
  }
  float ypos(float u, float v) {
    return r * cos(u) * cos(v);
  }
  float zpos(float u, float v) {
    return r * sin(v);
  }
}
