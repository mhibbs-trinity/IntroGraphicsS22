
class Cube extends Mesh3D {
  
  Cube(PVector center, float len) {
    //          1-------------2
    //         /|            /|
    //        d |           / |
    //       /  |          /  |
    //      0------w------3   |
    //      |   5---------|---6
    //      |  /          |  /
    //      h /           | /
    //      |/            |/
    //      4-------------7   
    //Vertices
    verts.add(new PVector(center.x-len/2, center.y-len/2, center.z+len/2)); //0
    verts.add(new PVector(center.x-len/2, center.y-len/2, center.z-len/2)); //1
    verts.add(new PVector(center.x+len/2, center.y-len/2, center.z-len/2)); //2
    verts.add(new PVector(center.x+len/2, center.y-len/2, center.z+len/2)); //3
    verts.add(new PVector(center.x-len/2, center.y+len/2, center.z+len/2)); //4
    verts.add(new PVector(center.x-len/2, center.y+len/2, center.z-len/2)); //5
    verts.add(new PVector(center.x+len/2, center.y+len/2, center.z-len/2)); //6
    verts.add(new PVector(center.x+len/2, center.y+len/2, center.z+len/2)); //7
    //Triangles
    //top
    tris.add(new int[] {0,1,2});
    tris.add(new int[] {0,2,3});
    //left
    tris.add(new int[] {5,1,0});
    tris.add(new int[] {5,0,4});
    //right
    tris.add(new int[] {7,3,2});
    tris.add(new int[] {7,2,6});
    //bottom
    tris.add(new int[] {5,4,7});
    tris.add(new int[] {5,7,6});
    //back
    tris.add(new int[] {6,2,1});
    tris.add(new int[] {6,1,5});
    //front
    tris.add(new int[] {4,0,3});
    tris.add(new int[] {4,3,7});
  }
}
