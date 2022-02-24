int[][] data;
void setup() {
  String[] dataStrs = loadStrings("someData.txt");
  data = new int[dataStrs.length-1][];
  for(int i=0; i<dataStrs.length-1; i++) {
    String[] parts = dataStrs[i+1].split("\t");
    data[i] = new int[parts.length];
    for(int j=0; j<parts.length; j++) {
      data[i][j] = int(parts[j]); 
    }
  }
  size(800,800);
}

void draw() {
  translate(0,height);
  scale(1, -1);
  background(0);
  stroke(255);
  for(int r=0; r<data.length; r++) {
    float x = map(r, 0,data.length, 0,width);
    if(mouseX >= x && mouseX <= x+width/data.length) {
      fill(255);
      pushMatrix();
      resetMatrix();
      text(data[r][0] + ": " + data[r][1], mouseX,mouseY);
      popMatrix();
    } else { fill(128); }
    rect(x,0, width/data.length,map(data[r][1], 0,90000, 0,height)); 
  }
}
