PFont gridFont;
PFont lblFont;
float gridTxtSz;
float lblTxtSz;
char exmpKey;
Vector2D xAxsLbl;
Vector2D yAxsLbl;
Vector2D off;
float scale;

UnitCircle uc;

void setup() {
  size(500,500);
  exmpKey = 'A';
  off = new Vector2D(width/2,height/2);
  scale = 200;
  
  gridTxtSz = width/40;
  lblTxtSz = width/25;
  gridFont = createFont("Helvetica", gridTxtSz);
  lblFont = createFont("Helvetica-Bold",lblTxtSz);
  textFont(gridFont);
  textAlign(CENTER,CENTER);
  
  ellipseMode(CENTER);
}

void draw() {
  background(240);
  //initialization
  float[] toLabel = {-1,-0.75,-0.5,-0.25,0.25,0.5,0.75,1};
  translate(off.x,off.y);
  axes(toLabel);
  radialAxes();
  
  //Drawing the UnitCircle itself...
  stroke(20);
  strokeWeight(2);
  noFill();
  ellipse(0,0, 2*scale,2*scale);
  
  //The main vector!
  Vector2D mouseVec = new Vector2D(mouseX-off.x,mouseY-off.y,"",3,color(0));
  mouseVec = mouseVec.norm();
  float unitX = mouseVec.x;
  float unitY = mouseVec.y;
  float delta = (mouseVec.y>0 ? acos(unitX) : 2*PI-acos(unitX));
  mouseVec = mouseVec.scale(scale);
  mouseVec.label = ""; //" π (" + nf(sldX,0,2) +","+ nf(sldY,0,2) + ")";
  mouseVec.display();
  
  //Labels
  pushMatrix();
  translate(mouseVec.x*0.5, mouseVec.y);
  text("x = cos(∂)="+nf(cos(delta),1,2), 0,0);
  popMatrix();
  pushMatrix();
  translate(mouseVec.x, mouseVec.y*0.5);
  text("y = sin(∂)="+nf(sin(delta),1,2), 0,0);
  popMatrix();

  //Angle indicator
  float buf = PI/8;
  stroke(0);
  strokeWeight(3);
  noFill();
  float r = 0.2*scale;
  println(delta);
  arc(0,0,r,r, buf,delta-buf);
  pushMatrix();
  translate(r/2,r/2);
  textAlign(LEFT,CENTER);
  text("∂="+nf(delta,1,2) +"="+nf(delta/PI,1,2)+"π", 0,0);
  textAlign(CENTER,CENTER);
  popMatrix();

  //Drawing the connection boxes:
  stroke(128);
  strokeWeight(1);
  line(unitX*scale,unitY*scale, unitX*scale,0);
  line(unitX*scale,unitY*scale, 0,unitY*scale);
  

}

class UnitCircle {
  
}

 

void axes(float[] toLabel) {
  color lblCol = 200;
  color gridCol = color(200,200,200,128);
  stroke(lblCol);
  fill(lblCol);
  textFont(gridFont);
  line(-width,0, +width,0);
  line(0,-height, 0,+height);
  stroke(gridCol);
  strokeWeight(1);
  for(int i=0; i<toLabel.length; i++) {
    pushMatrix();
    translate(toLabel[i]*scale, -gridTxtSz*0.75);
    text(str(toLabel[i]), 0,0);
    line(0,-height, 0,+height);
    popMatrix();
    pushMatrix();
    rotate(-PI/2);
    translate(-toLabel[i]*scale, -gridTxtSz*0.75);
    text(str(toLabel[i]), 0,0);
    line(0,-width, 0,+width);
    popMatrix();
  }
}

void radialAxes() {
   fill(60,60,60,128);
   stroke(color(60,60,60,128));
   strokeWeight(2);
   for(float phi=0; phi<2*PI; phi+=PI/8) {
     pushMatrix();     
     rotate(phi);
     translate(scale,0);
     line(scale*0.025,0, -scale*0.025,0);
     translate(scale*0.15,0);
     rotate(-phi);
     text(str(int(round(phi/PI*8))/8.0) + " π", 0,0);
    popMatrix(); 
   }
}

int sign(float z) { if(z>=0) return +1; else return -1; }

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
  
  //Display:
  void display() {
    stroke(col);
    fill(col);
    textFont(gridFont);
    strokeWeight(thickness);
    //Main heart of vector:
    line(0,0, x,y);
    
    //Label text:
    pushMatrix();
    //To the center of the vector, rotate perpendicular
    translate(x/2,y/2);
    float phi = atan(y/x);
    rotate(phi);
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

