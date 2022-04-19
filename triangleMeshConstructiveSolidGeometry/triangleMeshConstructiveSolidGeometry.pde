import peasy.*;
PeasyCam cam;

enum Mode { BOXES, SPHERES, MIXED }
Mode mode = Mode.BOXES;

Cube centralBox = new Cube(new PVector(0,0,0), 200);
Cube offsetBox = new Cube(new PVector(100,100,0), 150);
Sphere centralSphere = new Sphere(new PVector(0,0,0), 150, 20);
Sphere leftSphere = new Sphere(new PVector(-120,0,0), 80, 8);

Mesh3D boxesIntersect = centralBox.intersect(offsetBox);
Mesh3D boxesDifference = centralBox.difference(offsetBox);
Mesh3D boxesUnion = centralBox.union(offsetBox);

Mesh3D spheresIntersect = leftSphere.intersect(centralSphere);
Mesh3D spheresDifference = leftSphere.difference(centralSphere);
Mesh3D spheresUnion = leftSphere.union(centralSphere);

Mesh3D mixedIntersect = centralBox.intersect(centralSphere);
Mesh3D mixedDifference = centralBox.difference(centralSphere);
Mesh3D mixedUnion = centralBox.union(centralSphere);

void setup() {
  size(500,500,P3D);
  cam = new PeasyCam(this, 0,0,0, 500);
  translate(width/2, height/2);
  
  BSPTree tree = centralSphere.toBSPTree();//printPreOrderTraverse();
  tree.printPreOrderTraversal();
  
  pushMatrix();
}

void draw() {
  lights();
  background(0);

  stroke(255);
  fill(128);
  
  if(mode == Mode.BOXES) {  
    if(keyPressed && key == 'i') {
      boxesIntersect.display();
    } else if(keyPressed && key == 'd') {
      boxesDifference.display();
    } else if(keyPressed && key == 'u') {
      boxesUnion.display();
    } else {
      centralBox.display();
      offsetBox.display();
    }
  }
  if(mode == Mode.SPHERES) {
    if(keyPressed && key == 'i') {
      spheresIntersect.display();
    } else if(keyPressed && key == 'd') {
      spheresDifference.display();
    } else if(keyPressed && key == 'u') {
      spheresUnion.display();
    } else {
      centralSphere.display();
      leftSphere.display();
    }
  }
  if(mode == Mode.MIXED) {
    if(keyPressed && key == 'i') {
      mixedIntersect.display();
    } else if(keyPressed && key == 'd') {
      mixedDifference.display();
    } else if(keyPressed && key == 'u') {
      mixedUnion.display();
    } else {
      centralSphere.display();
      centralBox.display();
    }
  }
}

void keyPressed() {
  if(key == 'b') mode = Mode.BOXES;
  if(key == 's') mode = Mode.SPHERES;
  if(key == 'm') mode = Mode.MIXED;
}
