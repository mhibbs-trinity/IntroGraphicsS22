PFont gridFont;
PFont lblFont;
float gridTxtSz;
float lblTxtSz;
char exmpKey;
Vector2D xAxsLbl;
Vector2D yAxsLbl;
Vector2D off;
float scale;

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
  text("x = cos(∂)="+nf(cos(delta),1,2), 0,-gridTxtSz*0.75);
  popMatrix();
  pushMatrix();
  translate(mouseVec.x, mouseVec.y*0.5);
  rotate(HALF_PI);
  text("y = sin(∂)="+nf(sin(delta),1,2), 0,-gridTxtSz*0.75);
  popMatrix();

  //Angle indicator
  float buf = PI/8;
  stroke(0);
  strokeWeight(3);
  noFill();
  float r = 0.2*scale;
  //println(delta);
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


 
