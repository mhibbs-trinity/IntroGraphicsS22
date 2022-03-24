
DragCircle p1, p2, p3;
DragCircle PT; 

public enum Mode { SINGLEPT, INTERPOLATE };
Mode mode = Mode.SINGLEPT;
void keyPressed() {
  if(key == 's') mode = Mode.SINGLEPT;
  if(key == 'i') mode = Mode.INTERPOLATE;
}

void setup() {
  size(500,500);
  p1 = new DragCircle(100,100,10);
  p1.regularColor = color(255,0,0);
  p2 = new DragCircle(400,200,10);
  p2.regularColor = color(0,255,0);
  p3 = new DragCircle(250,400,10);
  p3.regularColor = color(0,0,255);
  PT = new DragCircle(200,300,40); 
}

void draw() {
  background(0);
  p1.display();
  p2.display();
  p3.display();
  
  
  if(mode == Mode.SINGLEPT) {
    //Determine the Barycentric Coordinates of point PT
    float denom = (p2.y-p3.y)*(p1.x-p3.x)+(p3.x-p2.x)*(p1.y-p3.y);
    float l1   = ((p2.y-p3.y)*(PT.x-p3.x)+(p3.x-p2.x)*(PT.y-p3.y)) / denom;
    float l2   = ((p3.y-p1.y)*(PT.x-p3.x)+(p1.x-p3.x)*(PT.y-p3.y)) / denom;
    float l3   = 1 - l1 - l2;
    
    //Using the Barycentric Coordinates, mix the colors for the point PT
    float r = l1 * red(p1.regularColor)   + l2 * red(p2.regularColor)   + l3 * red(p3.regularColor);
    float g = l1 * green(p1.regularColor) + l2 * green(p2.regularColor) + l3 * green(p3.regularColor);
    float b = l1 * blue(p1.regularColor)  + l2 * blue(p2.regularColor)  + l3 * blue(p3.regularColor);
    
    fill(255);
    text("(" + int(r) + "," + int(g) + "," + int(b) + ")", 10,height-12);
    
    if(l1 >= 0f && l2 >= 0f && l3 >= 0f) {
      PT.regularColor = color(r,g,b);
    } else {
      PT.regularColor = color(128);
    }
    PT.highlightColor = PT.regularColor;
    PT.display();
  }
  
  if(mode == Mode.INTERPOLATE) {
    for(float l1=0f; l1<=1.01f; l1+=0.01) {
      for(float l2=0f; l2<=1.01f; l2+=0.01) {
        float l3 = 1 - l1 - l2;
        
        if(l3 >= -0.01f) {
          PVector pt1 = new PVector(p1.x,p1.y);
          PVector pt2 = new PVector(p2.x,p2.y);
          PVector pt3 = new PVector(p3.x,p3.y);
          PVector p = PVector.mult(pt1,l1).add(PVector.mult(pt2,l2)).add(PVector.mult(pt3,l3));
          
          float r = l1 * red(p1.regularColor)   + l2 * red(p2.regularColor)   + l3 * red(p3.regularColor);
          float g = l1 * green(p1.regularColor) + l2 * green(p2.regularColor) + l3 * green(p3.regularColor);
          float b = l1 * blue(p1.regularColor)  + l2 * blue(p2.regularColor)  + l3 * blue(p3.regularColor);
          stroke(r,g,b);
          strokeWeight(5);
          point(p.x, p.y);
        }
      }
    }
    
  }
}
