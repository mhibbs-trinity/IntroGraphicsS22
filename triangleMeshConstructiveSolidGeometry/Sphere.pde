
class Sphere extends Mesh3D {
  Sphere(PVector center, float r, int nSeg) {
    float uStep = 2*PI/nSeg;
    float vStep = PI/nSeg;
    for(float u=0; u<2*PI; u+=uStep) {
      for(float v=-PI/2; v<PI/2; v+=vStep) {
        PVector a = makeVector(center,r,u,v);
        PVector b = makeVector(center,r,u+uStep,v);
        PVector c = makeVector(center,r,u+uStep,v+vStep);
        PVector d = makeVector(center,r,u,v+vStep);
        verts.add(a);
        verts.add(b);
        verts.add(c);
        verts.add(d);
        //Add triangles for this face
        tris.add(new int[] {verts.size()-1,verts.size()-2,verts.size()-3});
        tris.add(new int[] {verts.size()-3,verts.size()-4,verts.size()-1});
      }
    }
  }
  private PVector makeVector(PVector center, float r, float u, float v) {
    return new PVector(xpos(center,r,u,v), ypos(center,r,u,v), zpos(center,r,u,v));
  }
  private float xpos(PVector center, float r, float u, float v) {
    return center.x + r * sin(u) * cos(v);
  }
  private float ypos(PVector center, float r, float u, float v) {
    return center.y + r * cos(u) * cos(v);
  }
  private float zpos(PVector center, float r, float u, float v) {
    return center.z + r * sin(v);
  }
}
