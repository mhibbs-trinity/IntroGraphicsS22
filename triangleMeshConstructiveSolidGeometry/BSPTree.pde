class BSPTree {
  float eps = 0.0005;
  
  class BSPNode {
    MyTri t;
    BSPNode front, back;
    BSPNode(MyTri _t) {
      t = _t;
      front = null;
      back = null;
    }
    /*
     * This add method is used to construct a BSP Tree from a series of
     * triangles added to the tree. As such, none of the triangles should
     * intersect with each other. If that happens, a false value is returned
     * to indicate that the triangle was not successfully added, otherwise
     * true is returned to show that the triangle/plane was added correctly.
     */
    boolean add(MyTri tri) {
      float fa = t.getFrontBack(tri.a);
      float fb = t.getFrontBack(tri.b);
      float fc = t.getFrontBack(tri.c);
      if(fa <= 0 && fb <= 0 && fc <= 0) {
        if(back == null) {
          back = new BSPNode(tri);
          return true;
        }
        else return back.add(tri);
      } else if(fa >= 0 && fb >= 0 && fc >= 0) {
        if(front == null) {
          front = new BSPNode(tri);
          return true;
        }
        else return front.add(tri);
      } else {
        println("Triangle to subdivide during add: " + fa + "," + fb + "," + fc);
        //This is a trinanlge that intersects during the adding process,
        //So, just add this to both sides...
        /*
        if(back == null) {
          back = new BSPNode(tri);
        }
        if(front == null) {
          front = new BSPNode(tri);
        }*/
        //return true;
        return false;
      }
    }
    void display() {
      t.display();
      if(front != null) front.display();
      if(back != null) back.display();
    }
    void preOrderTraverse(ArrayList<MyTri> result) {
      result.add(t);
      if(back != null) back.preOrderTraverse(result);
      if(front != null) front.preOrderTraverse(result);
    }
    void printPreOrderTraverse() {
      //print("["+t.a+","+t.b+","+t.c+"]");
      if(back != null)  { back.printPreOrderTraverse(); }
      if(front != null) { front.printPreOrderTraverse(); }
    }
    
    /*
     This function is used to determine whether a triangle is in- or out-
     side of the BSPTree. The triangle is added to either the inside or outside
     argument, and if needed it is split into smaller triangles when the 
     triangle intersects one of the BSP planes.
     */
    void insert(MyTri tri, ArrayList<MyTri> inside, ArrayList<MyTri> outside) {
      float fa = t.getFrontBack(tri.a);
      float fb = t.getFrontBack(tri.b);
      float fc = t.getFrontBack(tri.c);
      if(fa <= 0 && fb <= 0 && fc <= 0) {
        if(back == null) inside.add(tri);
        else back.insert(tri, inside, outside);
      } else if(fa >= 0 && fb >= 0 && fc >= 0) {
        if(front == null) outside.add(tri);
        else front.insert(tri, inside, outside);
      } else { 
        if(abs(fa) <= eps && abs(fb) <= eps && abs(fc) <= eps) {
          println("WARNING: Co-planar insertion: skipping this triangle");
        }
        //Determine if need a 2 or 3 triangle split
        else if(fa == 0 || fb == 0 || fc == 0) {
          PVector out, in1, in2;
          if(fa == 0)      { out = tri.a; in1 = tri.b; in2 = tri.c; }
          else if(fb == 0) { out = tri.b; in1 = tri.c; in2 = tri.a; }
          else if(fc == 0) { out = tri.c; in1 = tri.a; in2 = tri.b; }
          else {
            println("WARNING: insert: split: No vertex has different sign than other two vertices");
            //This is here for debugging, and because Java complains if variables aren't ever initialized
            out = new PVector(); in1 = new PVector(); in2 = new PVector();
          }
          //Find the intersection point
          PVector I = PVector.add(in1, PVector.mult(PVector.sub(in2,in1), PVector.sub(t.a,in1).dot(t.n) / PVector.sub(in2,in1).dot(t.n)));
          //Insert the 2 new triangles
          insert(new MyTri(out, in1, I), inside, outside);
          insert(new MyTri(out, I, in2), inside, outside);
          
        } else {
          //Determine the "lone" vertex
          boolean fapos = fa > 0;
          boolean fbpos = fb > 0;
          boolean fcpos = fc > 0;
          PVector out, in1, in2;
          if(fapos != fbpos && fapos != fcpos)      { out = tri.a; in1 = tri.b; in2 = tri.c; }
          else if(fbpos != fapos && fbpos != fcpos) { out = tri.b; in1 = tri.c; in2 = tri.a; }
          else if(fcpos != fapos && fcpos != fbpos) { out = tri.c; in1 = tri.a; in2 = tri.b; }
          else {
            println("WARNING: insert: split: No vertex has different sign than other two vertices");
            out = new PVector(); in1 = new PVector(); in2 = new PVector();
          }
          
          //Find the intersection points of two edges intersecting with the split plane, I1 & I2
          PVector I1 = PVector.add(in1, PVector.mult(PVector.sub(out,in1), PVector.sub(t.a,in1).dot(t.n) / PVector.sub(out,in1).dot(t.n)));
          PVector I2 = PVector.add(in2, PVector.mult(PVector.sub(out,in2), PVector.sub(t.a,in2).dot(t.n) / PVector.sub(out,in2).dot(t.n)));
          
          //Insert the 3 new triangles
          insert(new MyTri(in1, in2, I1), inside, outside);
          insert(new MyTri(I1, I2, out), inside, outside);
          insert(new MyTri(I1, in2, I2), inside, outside);
          
        }
      }
    }
  }
  
  //Fields
  BSPNode root;
  
  //Constructor
  BSPTree() {
    root = null;
  }
  
  //Methods
  boolean add(MyTri t) {
    if(root == null) {
      root = new BSPNode(t);
      return true;
    }
    else return root.add(t);
  }
  void display() {
    root.display(); 
  }
  ArrayList<MyTri> preOrderTraversal() {
    ArrayList<MyTri> result = new ArrayList<MyTri>();
    if(root != null) root.preOrderTraverse(result);
    return result;
  }
  void printPreOrderTraversal() {
    root.printPreOrderTraverse();
  }
  
  Mesh3D intersection(BSPTree other) {
    //Determine in/out of this to other
    ArrayList<MyTri> thisTris = preOrderTraversal();
    ArrayList<MyTri> thisInsideOther = new ArrayList<MyTri>();
    ArrayList<MyTri> thisOutsideOther = new ArrayList<MyTri>();
    for(MyTri tri : thisTris) {
      other.root.insert(tri, thisInsideOther, thisOutsideOther);
    }
    //Determine in/out of other to this
    ArrayList<MyTri> otherTris = other.preOrderTraversal();
    ArrayList<MyTri> otherInsideThis = new ArrayList<MyTri>();
    ArrayList<MyTri> otherOutsideThis = new ArrayList<MyTri>();
    for(MyTri tri : otherTris) {
      root.insert(tri, otherInsideThis, otherOutsideThis);
    }
    //Combine the triangles for the intersection operation
    ArrayList<MyTri> result = new ArrayList<MyTri>();
    result.addAll(thisInsideOther);
    result.addAll(otherInsideThis);
    Mesh3D mesh = new Mesh3D();
    for(MyTri t : result) {
      mesh.verts.add(t.a);
      mesh.verts.add(t.b);
      mesh.verts.add(t.c);
      mesh.tris.add(new int[] { mesh.verts.size()-3, 
                                mesh.verts.size()-2,
                                mesh.verts.size()-1 });
    }
    return mesh;
  }
  
  Mesh3D union(BSPTree other) {
    //Determine in/out of this to other
    ArrayList<MyTri> thisTris = preOrderTraversal();
    ArrayList<MyTri> thisInsideOther = new ArrayList<MyTri>();
    ArrayList<MyTri> thisOutsideOther = new ArrayList<MyTri>();
    for(MyTri tri : thisTris) {
      other.root.insert(tri, thisInsideOther, thisOutsideOther);
    }
    //Determine in/out of other to this
    ArrayList<MyTri> otherTris = other.preOrderTraversal();
    ArrayList<MyTri> otherInsideThis = new ArrayList<MyTri>();
    ArrayList<MyTri> otherOutsideThis = new ArrayList<MyTri>();
    for(MyTri tri : otherTris) {
      root.insert(tri, otherInsideThis, otherOutsideThis);
    }
    //Combine the triangles for the union operation
    ArrayList<MyTri> result = new ArrayList<MyTri>();
    result.addAll(thisOutsideOther);
    result.addAll(otherOutsideThis);
    Mesh3D mesh = new Mesh3D();
    for(MyTri t : result) {
      mesh.verts.add(t.a);
      mesh.verts.add(t.b);
      mesh.verts.add(t.c);
      mesh.tris.add(new int[] { mesh.verts.size()-3, 
                                mesh.verts.size()-2,
                                mesh.verts.size()-1 });
    }
    return mesh;
  }  

  Mesh3D difference(BSPTree other) {
    //Determine in/out of this to other
    ArrayList<MyTri> thisTris = preOrderTraversal();
    ArrayList<MyTri> thisInsideOther = new ArrayList<MyTri>();
    ArrayList<MyTri> thisOutsideOther = new ArrayList<MyTri>();
    for(MyTri tri : thisTris) {
      other.root.insert(tri, thisInsideOther, thisOutsideOther);
    }
    //Determine in/out of other to this
    ArrayList<MyTri> otherTris = other.preOrderTraversal();
    ArrayList<MyTri> otherInsideThis = new ArrayList<MyTri>();
    ArrayList<MyTri> otherOutsideThis = new ArrayList<MyTri>();
    for(MyTri tri : otherTris) {
      root.insert(tri, otherInsideThis, otherOutsideThis);
    }
    //Combine the triangles for the difference operation
    ArrayList<MyTri> result = new ArrayList<MyTri>();
    result.addAll(thisOutsideOther);
    result.addAll(otherInsideThis);
    Mesh3D mesh = new Mesh3D();
    for(MyTri t : result) {
      mesh.verts.add(t.a);
      mesh.verts.add(t.b);
      mesh.verts.add(t.c);
      mesh.tris.add(new int[] { mesh.verts.size()-3, 
                                mesh.verts.size()-2,
                                mesh.verts.size()-1 });
    }
    return mesh;
  }
  
}
