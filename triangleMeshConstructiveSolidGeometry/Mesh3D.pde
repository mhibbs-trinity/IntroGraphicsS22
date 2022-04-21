
class Mesh3D {
  ArrayList<PVector> verts;
  ArrayList<int[]> tris;
  
  Mesh3D() {
    verts = new ArrayList<PVector> ();
    tris = new ArrayList<int[]> ();
  }
  
  BSPTree toBSPTree() {
    BSPTree tree = new BSPTree();
    java.util.Collections.shuffle(tris);
    for(int[] tri : tris) {
      tree.add(new MyTri(verts.get(tri[0]),verts.get(tri[1]),verts.get(tri[2])));
    }
    return tree;
  }
  
  void display() {
    beginShape(TRIANGLES);
    for(int[] tri : tris) {
       triangleHelper(tri);
    }
    endShape();
  }
  
  private void triangleHelper(int[] tri) {
    vertexHelper(tri[0]);
    vertexHelper(tri[1]);
    vertexHelper(tri[2]);
  }
  
  private void vertexHelper(int i) {
    PVector v = verts.get(i);
    vertex(v.x,v.y,v.z);
  }
  
  Mesh3D intersect(Mesh3D other) {
    BSPTree atree = this.toBSPTree();
    BSPTree btree = other.toBSPTree();
    return (atree.intersection(btree));
  }
  Mesh3D difference(Mesh3D other) {
    BSPTree atree = this.toBSPTree();
    BSPTree btree = other.toBSPTree();
    return (atree.difference(btree));
  }
  Mesh3D union(Mesh3D other) {
    BSPTree atree = this.toBSPTree();
    BSPTree btree = other.toBSPTree();
    return (atree.union(btree));
  }
  
}
