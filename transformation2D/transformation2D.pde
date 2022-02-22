/* This sketch uses 2D transformations to draw two different rectangles
 * with the same "local" coordinates (150,200, 200,100) that behave differently
 * because of the transformation matrix. The black rectangle rotates around its
 * top left corner as the mouse moves horizontally. The red rectangle scales
 * from its center point as the mouse moves vertically.
 */

void setup() {
  size(500,500);
}

void draw() {
  background(255);
  strokeWeight(4);
  noFill();
  
  //To rotate around a point other than the origin, a good strategy is to
  //translate the origin to the point of rotation, perform the rotation,
  //and then translate the origin "back" to its original location
  pushMatrix();
  translate(150,200);
  rotate(map(mouseX, 0,width, 0,TWO_PI));
  translate(-150,-200);
  
  stroke(0);
  rect(150,200, 200,100);
  popMatrix();
  
  //Similarly for scaling, if you want to scale centered around a particular
  //point, translate the origin there, do the scaling, and then translate back
  pushMatrix();
  translate(250,250);
  scale(map(mouseY, 0,height, 1,3));
  translate(-250,-250);

  stroke(200,50,50);
  rect(150,200, 200,100);
  popMatrix();
}
