class IcoSphere {
  //Treat this IcoSphere as a Unit sphere centered on the origin
  Mesh3D mesh;

  //Constructor
  IcoSphere() {
    float phi = (1 + sqrt(5)) / 2;
    mesh = new Mesh3D ();
    
    addNormalVertex(-phi,-1,0); //0
    addNormalVertex( phi,-1,0); //1
    addNormalVertex( phi, 1,0); //2
    addNormalVertex(-phi, 1,0); //3

    addNormalVertex(0,-phi, 1); //4
    addNormalVertex(0,-phi,-1); //5
    addNormalVertex(0, phi,-1); //6 
    addNormalVertex(0, phi, 1); //7

    addNormalVertex(-1,0, phi); //8
    addNormalVertex(-1,0,-phi); //9
    addNormalVertex( 1,0,-phi); //10
    addNormalVertex( 1,0, phi); //11
    
    addTriangle(0,5,4);
    addTriangle(0,4,8);
    addTriangle(0,8,3);
    addTriangle(0,3,9);
    addTriangle(0,9,5);
    
    addTriangle(1,4,5);
    addTriangle(1,5,10);
    addTriangle(1,10,2);
    addTriangle(1,2,11);
    addTriangle(1,11,4);
    
    addTriangle(7,8,11);
    addTriangle(7,11,2);
    addTriangle(7,2,6);
    addTriangle(7,6,3);
    addTriangle(7,3,8);
    
    addTriangle(6,2,10);
    addTriangle(6,10,9);
    addTriangle(6,9,3);
    addTriangle(5,9,10);
    addTriangle(4,11,8);
    
    createSphericalUVs();
  }
  
  private void addNormalVertex(float a, float b, float c) {
    PVector v = new PVector(a,b,c);
    v.normalize();
    mesh.verts.add(v);
    mesh.norms.add(v.get());
    //PVector uv = new PVector(asin(v.x)/PI + 0.5, asin(v.y)/PI + 0.5, 0);
    //mesh.uvs.add(uv);
  }
  
  private void addTriangle(int a, int b, int c) {
    int[] tarray = {a, b, c};
    mesh.tris.add(tarray);
  }
  
  void createSphericalUVs() {
    mesh.uvs = new ArrayList<PVector>();
    for(PVector pt : mesh.verts) {
      float v = asin(pt.z);
      //float u1 = acos( pt.x / cos(v) );
      //float u2 = asin( pt.y / cos(v) );
      float u3 = atan2( pt.x, pt.y );
      //if(sin(v) == 0f) { u1 = PI; }
      
      PVector uv = new PVector(map(u3,-PI,PI,1,0), (v + HALF_PI) / PI, 0);
      mesh.uvs.add(uv);
    }
  }
 
  void subdivideAllTris() {
    ArrayList<PVector> newVerts = new ArrayList<PVector>();
    ArrayList<PVector> newNorms = new ArrayList<PVector>();
    ArrayList<int[]> newTris = new ArrayList<int[]>();
    
    int ctr = 0;
    for(int[] tri : mesh.tris) {
       PVector[] p = new PVector [6];
       p[0] = mesh.verts.get(tri[0]);
       p[1] = mesh.verts.get(tri[1]);
       p[2] = mesh.verts.get(tri[2]);
       
       p[3] = PVector.add(p[0],p[1]);
       p[3].normalize();
       p[4] = PVector.add(p[1],p[2]);
       p[4].normalize();
       p[5] = PVector.add(p[2],p[0]);
       p[5].normalize();
       
       for(int i=0; i<6; i++) {
         newVerts.add(p[i]);
         newNorms.add(p[i]);
       }
       int[] t0 = new int[3];
       t0[0] = ctr+0;
       t0[1] = ctr+3;
       t0[2] = ctr+5;
       newTris.add(t0);
       
       int[] t1 = new int[3];
       t1[0] = ctr+3;
       t1[1] = ctr+1;
       t1[2] = ctr+4;
       newTris.add(t1);
       
       int[] t2 = new int[3];
       t2[0] = ctr+4;
       t2[1] = ctr+2;
       t2[2] = ctr+5;
       newTris.add(t2);
       
       int[] t3 = new int[3];
       t3[0] = ctr+3;
       t3[1] = ctr+4;
       t3[2] = ctr+5;
       newTris.add(t3);
       
       ctr += 6;
    }
    
    mesh.verts = newVerts;
    mesh.norms = newNorms;
    mesh.tris = newTris;
    
    createSphericalUVs();
    
  }
 
  void display() {
    mesh.display();
  }
  
  void display(PImage img) {
    textureMode(NORMAL);
    mesh.display(img);
  } 
  
}
