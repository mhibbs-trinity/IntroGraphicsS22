void axes(int[] toLabel) {
  color lblCol = 200;
  color gridCol = color(200,200,200,128);
  stroke(lblCol);
  fill(lblCol);
  textFont(gridFont);
  line(-width,0, +width,0);
  line(0,-height, 0,+height);
  stroke(gridCol);
  for(int i=0; i<toLabel.length; i++) {
    pushMatrix();
    translate(toLabel[i], -gridTxtSz*0.75);
    text(str(toLabel[i]), 0,0);
    line(0,-2*height, 0,+2*height);
    popMatrix();
    pushMatrix();
    rotate(-PI/2);
    translate(-toLabel[i], -gridTxtSz*0.75);
    text(str(toLabel[i]), 0,0);
    line(0,-2*width, 0,+2*width);
    popMatrix();
  }
}

void showAddition(Vector2D vec1, Vector2D vec2) {
  Vector2D sumV = vec1.add(vec2);
  sumV.col = lerpColor(vec1.col, vec2.col, 0.5);
  Vector2D lightVec1 = vec1.clone();
  color v1col = vec1.col;
  lightVec1.col = color(red(v1col),green(v1col),blue(v1col),128);
  lightVec1.label = vec1.label + "'";
  pushMatrix();
  translate(vec2.x,vec2.y);
  lightVec1.display();
  popMatrix();
  Vector2D lightVec2 = vec2.clone();
  lightVec2.col = lerpColor(vec2.col,color(255,255,255,0),0.5);
  lightVec2.label = vec2.label + "'";
  pushMatrix();
  translate(vec1.x,vec1.y);
  lightVec2.display();
  popMatrix();
  sumV.label = vec1.label + "+" + vec2.label;
  sumV.display();
}
  
void showSubtraction(Vector2D vec1, Vector2D vec2) {
  Vector2D subV = vec1.sub(vec2);
  subV.col = lerpColor(vec1.col, vec2.col, 0.5);
  Vector2D lightVec2 = vec2.invert();
  lightVec2.col = lerpColor(vec2.col,color(255,255,255,0),0.5);
  lightVec2.label = "- "+vec2.label;
  pushMatrix();
  translate(vec1.x,vec1.y);
  lightVec2.display();
  popMatrix();
  subV.label = vec1.label + "-" + vec2.label;
  subV.display();
}
