
class Vector2D { 
  //Instance variables:
  float x;
  float y;
  String label;
  float thickness;
  int col;
  
  //Constructors:
  Vector2D() {
    x = 0;
    y = 0;
    label = "";
    thickness = 1;
    col = 0;
  }
  Vector2D(float inx, float iny) {
    x = inx;
    y = iny;
    label = "";
    thickness = 1;
    col = 0;
  }
  Vector2D(float inx, float iny, String inlabel) {
    x = inx;
    y = iny;
    label = inlabel;
    thickness = 1;
    col = 0;
  }
  Vector2D(float inx, float iny, String inlabel, float inthick, int incol) {
    x = inx;
    y = iny;
    label = inlabel;
    thickness = inthick;
    col = incol;
  }
  
  //Methods:
  String toString() {
    String str = label+": ("+str(x)+","+str(y)+")";
    return str;
  } 
  
  //Basic vector arithmetic:
  Vector2D add(Vector2D other) {
    return new Vector2D(x+other.x,y+other.y,label+" + "+other.label,thickness,lerpColor(col,other.col,0.5));
  }
  Vector2D sub(Vector2D other) {
    return new Vector2D(x-other.x,y-other.y,label+" - "+other.label,thickness,lerpColor(col,other.col,0.5));
  }
  float dot(Vector2D other) {
    return x*other.x + y*other.y;
  }
  float dist() {
    return sqrt(dot(this)); 
  }
  Vector2D norm() {
    float len = dist();
    return new Vector2D(x/len,y/len,"norm("+label+")",thickness, col);
  }
  Vector2D orthoNorm() {
    return this;
  }
  Vector2D clone() {
    return new Vector2D(x,y,label,thickness,col);
  }
  float theta() {
    Vector2D n = norm();
    float thex = abs(n.x) + ( n.x<0 ? abs(n.x) : 0 );
    return acos (n.x);
  } 
  
  //Transformatons
  Vector2D trotate() {
    return this;
  }
  Vector2D scale(float scl) {
    Vector2D cln = clone();
    cln.x *= scl;
    cln.y *= scl;
    return cln;
  }
  Vector2D invert() {
    Vector2D cln = clone();
    cln.x *= -1;
    cln.y *= -1;
    return cln;
  }
  void invertME() {
    x *= -1;
    y *= -1;
  }
  
  //Display:
  void display() {
    stroke(col);
    fill(col);
    textFont(lblFont);
    strokeWeight(thickness);
    //Main heart of vector:
    line(0,0, x,y);
    
    //Label text:
    pushMatrix();
    //To the center of the vector, rotate perpendicular
    translate(x/2,y/2);
    float theta = atan(y/x);
    rotate(theta);
    //then slightly above the vector
    translate(0,-lblTxtSz*0.75);
    text(label, 0,0);
    popMatrix();
    
    //Arrowhead:
    pushMatrix();
    translate(x,y);
    rotate(y>0 ? theta() : -theta());
    rotate(5*PI/3);
    line(0,0, 0,-lblTxtSz*0.75);
    rotate(5*PI/3);
    line(0,0, 0,-lblTxtSz*0.75);
    popMatrix();
  }
}
  
