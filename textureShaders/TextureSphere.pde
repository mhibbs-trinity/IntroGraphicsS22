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
        createVertex(u,v);
        createVertex(u+uStep,v);
        createVertex(u+uStep,v+vStep);
        createVertex(u,v+vStep);
      }
    }
    endShape();
  }
  
  void displayWithRandomUV() {
    beginShape(QUADS);
    texture(img);
    float uStep = 2*PI/nSegs;
    float vStep = PI/nSegs;
    for(float u=0; u<2*PI; u+=uStep) {
      for(float v=-PI/2; v<PI/2; v+=vStep) {
        createVertexWithRandomUV(u,v);
        createVertexWithRandomUV(u+uStep,v);
        createVertexWithRandomUV(u+uStep,v+vStep);
        createVertexWithRandomUV(u,v+vStep);
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
    normal(norm.x,norm.y,norm.z);
    vertex(x,y,z, map(u, 0,2*PI, img.width,0), map(v, -PI/2,PI/2, 0,img.height));
  }
  
  void createVertexWithRandomUV(float u, float v) {
    float x = xpos(u,v);
    float y = ypos(u,v);
    float z = zpos(u,v);
    PVector norm = new PVector(x,y,z);
    norm.normalize();
    normal(norm.x,norm.y,norm.z);
    vertex(x,y,z, random(-200,200), random(-200,200));
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
