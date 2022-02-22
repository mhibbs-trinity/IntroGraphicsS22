/* vectors2Ddemo
 * This example uses a custom Vector2D class to simplify labeling and some display options.
 * In general, you will likely want to use the built-in PVector class for 2D vectors
 */

PFont gridFont;
PFont lblFont;
int gridTxtSz;
int lblTxtSz;
Vector2D vec1;
Vector2D vec2;
Vector2D vec3;
Vector2D vec4;
char exmpKey;
char defExmpKey = 'A';
Vector2D off;

void setup() {
  size(500, 500);
  exmpKey = defExmpKey;
  off = new Vector2D(50,50); 
  // Uncomment the following two lines to see the available fonts 
  //String[] fontList = PFont.list();
  //println(fontList);
  gridTxtSz = width/40;
  lblTxtSz = width/25;
  gridFont = createFont("Helvetica", gridTxtSz);
  lblFont = createFont("Helvetica-Bold",lblTxtSz);
  textFont(gridFont);
  vec1 = new Vector2D(200,50, "A", 3, color(200,50,30));
  vec2 = new Vector2D(125,200, "B", 3, color(100,60,210));
  vec3 = new Vector2D(50,200, "C", 3, color(80,220,60));
}

void draw() {
  //Reset background 
  background(40);
  showFrameRate();
  showInstructions();
  
  //Show axes/labels
  textAlign(CENTER, CENTER);
  translate(off.x,off.y);
  int[] toLabel = {-50,-100,-150,-200,-250,-300,-350,-400,-450,-500,50,100,150,200,250,300,350,400,450,500};
  axes(toLabel);  
  
  //Show main display based on selections:
  switch(exmpKey) {
    case 'A':
      vec1.display();
      vec2.display();
      vec3.display();
      break;
    case 'B':
      Vector2D mouseVec = new Vector2D(mouseX-off.x,mouseY-off.y,
                          "Mouse @ (" + str(mouseX-off.x) + "," + str(mouseY-off.y) +")",3,color(200));
      mouseVec.display();
      break;
    case 'C':
      vec1.display();
      vec2.display();
      //vec3.display();
      showAddition(vec1,vec2);
      //showAddition(vec2,vec3);
      break;
    case 'D':
      vec1.display();
      Vector2D subVec = (new Vector2D(mouseX-off.x,mouseY-off.y,"Z",3,0)).sub(vec1);
      subVec.col = color(255,255,255,128);
      subVec.label = "Z";
      subVec.display();
      showAddition(vec1,subVec);
      break;
    case 'E':
      vec1.display();
      vec2.display();
      //vec3.display();
      showSubtraction(vec1,vec2);
      //showSubtraction(vec2,vec3);
      break;
    case 'F':
      vec1.display();
      mouseVec = new Vector2D(mouseX-off.x,mouseY-off.y,"Mouse",3,color(255,255,255,128));
      mouseVec.display();
      showSubtraction(vec1,mouseVec);
      break;
  }
  
  //Handle mouse movements during a press event
  if(mousePressed) {
    off.x += (mouseX - prevX);
    prevX = mouseX;
    off.y += (mouseY - prevY);
    prevY = mouseY;
  }
}

void keyPressed() {
  if(key == 'A' || key == 'a') { exmpKey = 'A'; }
  else if(key == 'B' || key == 'b') { exmpKey = 'B'; }
  else if(key == 'C' || key == 'c') { exmpKey = 'C'; }
  else if(key == 'D' || key == 'd') { exmpKey = 'D'; }
  else if(key == 'E' || key == 'e') { exmpKey = 'E'; }
  else if(key == 'F' || key == 'f') { exmpKey = 'F'; }
}

void showFrameRate() {
  pushMatrix();
  textFont(gridFont);
  fill(255);
  translate(max(width*0.75,width-75),height-gridTxtSz*0.75);
  text("Frame rate = " + str(int(round(frameRate))), 0,0);
  popMatrix();
}

void showInstructions() {
  pushMatrix();
  textFont(gridFont);
  fill(255);
  textAlign(LEFT, CENTER);
  translate(width*0.05, height*0.8);
  text("Click & Drag mouse to pan coordinates",0,0);
  translate(0,gridTxtSz);
  text("Change Modes of Display with these keys:",0,0);
  translate(0,gridTxtSz);
  text("A = Static Vectors",0,0);
  translate(0,gridTxtSz);
  text("B = Dynamic Vector to current mouse location",0,0);
  translate(0,gridTxtSz);
  text("C = Static Vector addition example",0,0);
  translate(0,gridTxtSz);
  text("D = Dynamic Vector addition example",0,0);
  translate(0,gridTxtSz);
  text("E = Static Vector subtraction example",0,0);
  translate(0,gridTxtSz);
  text("F = Dynamic Vector subtraction example",0,0);
  translate(0,gridTxtSz);
  popMatrix();
}


float prevX=-1;
float prevY=-1;
void mousePressed() {
  if(prevX == -1) prevX = mouseX;
  if(prevY == -1) prevY = mouseY; 
}
void mouseReleased() {
  prevX = -1;
  prevY = -1;
}
