class Mesh3D {
  ArrayList<PVector> verts;
  ArrayList<PVector> uvs;
  ArrayList<PVector> norms;
  ArrayList<int[]> tris;
  
  Mesh3D() {
    verts = new ArrayList<PVector> ();
    uvs = new ArrayList<PVector> ();
    norms = new ArrayList<PVector> ();
    tris = new ArrayList<int[]> ();
  }
  
  void display() {
    beginShape(TRIANGLES);
    for(int[] tri : tris) {
      //triangleHelper(tri);
      normTriangleHelper(tri);
    }
    endShape();
  }
  
  void display(PImage img) {
    beginShape(TRIANGLES);
    texture(img);
    for(int[] tri : tris) {
      //triangleHelper(tri);
      normTriangleHelper(tri);
    }
    endShape();
  }
  
  void displayWithNormals() {
    beginShape(TRIANGLES);
    for(int[] tri : tris) {
      normTriangleHelper(tri);
    }
    endShape();
    
    beginShape(LINES);
    stroke(255,255,0);
    for(int i=0; i<norms.size(); i++) {
       stroke(255,255,0);
       PVector v = verts.get(i);
       vertex(v.x,v.y,v.z);
       stroke(0,255,255);
       PVector n = norms.get(i);
       vertex(v.x+n.x*0.2, v.y+n.y*0.2, v.z+n.z*0.2);
    }
    endShape();
  }
  
  private void triangleHelper(int[] tri) {
    vertexHelper(tri[0]);
    vertexHelper(tri[1]);
    vertexHelper(tri[2]);
  }
  
  private void normTriangleHelper(int[] tri) {
    normalHelper(tri[0]);
    vertexHelper(tri[0]);
    normalHelper(tri[1]);
    vertexHelper(tri[1]);
    normalHelper(tri[2]);
    vertexHelper(tri[2]);
  }
  
  private void normalHelper(int i) {
    PVector n = norms.get(i);
    normal(n.x,n.y,n.z);
  }
  
  private void vertexHelper(int i) {
    PVector v = verts.get(i);
    if(uvs.size() > i) {
      PVector uv = uvs.get(i);
      vertex(v.x,v.y,v.z, uv.x,uv.y);
    } else {
      vertex(v.x, v.y, v.z);
    }
  }
  
}
