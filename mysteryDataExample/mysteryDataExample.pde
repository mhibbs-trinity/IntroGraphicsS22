
//Using the Table class & loadTable
Table dataTable;
String columnLabel = "Number";
int columnMaxTable = 0;

//Using ArrayLists & BufferedReader
ArrayList<ArrayList<Integer>> dataList;
int columnListIdx = 3;
int columnMaxList = 0;

//Using primitive arrays & loadString
int[][] dataArray;
int columnArrayIdx = 3;
int columnMaxArray = 0;

void setup() {
  size(800,600);
  
  //TABLE
  dataTable = loadTable("someData.txt","header,tsv");
  for(TableRow row : dataTable.rows()) {
    if(row.getInt(columnLabel) > columnMaxTable) columnMaxTable = row.getInt(columnLabel);
  }
  
  //BUFFEREDREADER & ARRAYLISTS
  BufferedReader in = createReader("someData.txt");
  dataList = new ArrayList<ArrayList<Integer>>();
  try {
    String line = in.readLine();
    line = in.readLine(); //Skipping the header line by reading in 2 lines to start with
    while(line != null) {
      String[] parts = line.split("\t");
      ArrayList<Integer> currentRow = new ArrayList<Integer>();
      for(int i=0; i<parts.length; i++) {
        currentRow.add(int(parts[i]));
      }
      if(currentRow.get(columnListIdx) > columnMaxList) columnMaxList = currentRow.get(columnListIdx);
      dataList.add(currentRow);
      line = in.readLine();
    }
  } catch(IOException ex) {
    ex.printStackTrace();
  }
  
  //LOADSTRINGS & ARRAYS
  String[] lines = loadStrings("someData.txt");
  dataArray = new int[lines.length-1][];
  for(int i=0; i<lines.length-1; i++) {
    String[] parts = lines[i+1].split("\t");
    dataArray[i] = new int[parts.length];
    for(int j=0; j<parts.length; j++) {
      dataArray[i][j] = int(parts[j]);
    }
    if(dataArray[i][columnArrayIdx] > columnMaxArray) columnMaxArray = dataArray[i][columnArrayIdx];
  }
}


void draw() {
  background(20);
  
  //Move origin to lower left corner and swap direction of y-axis
  translate(0,height);
  scale(1,-1);
  
  //Uncomment mode to use:
  drawUsingTable();
  //drawUsingArrayList();
  //drawUsingArray();
  
}

void drawUsingTable() {
  //TABLE
  int rowCount = 0;
  for(TableRow row : dataTable.rows()) {
    fill(255);
    noStroke();
    float x = map(rowCount, 0,dataTable.getRowCount(), 0,width);
    // Uncomment for basic interactivity
    float endx = x + width/dataTable.getRowCount();
    if(mouseX >= x && mouseX < endx) {
      fill(255);
      String label = row.getString("Year") + ": " + row.getString(columnLabel);
      pushMatrix();
      resetMatrix();
      text(label, mouseX,mouseY);
      popMatrix();
    } else { fill(128); }
    //*/
    rect(x,0, width/dataTable.getRowCount(),map(row.getInt(columnLabel), 0,columnMaxTable, 0,height));
    rowCount++;
  }
}

void drawUsingArrayList() {
  //BUFFEREDREADER
  for(int row=0; row<dataList.size(); row++) {
    fill(200,50,50);
    noStroke();
    float x = map(row, 0,dataList.size(), 0,width);
    rect(x,0, width/dataList.size(),map(dataList.get(row).get(columnListIdx), 0,columnMaxList, 0,height));
  }
}

void drawUsingArray() {
  //ARRAYS
  for(int row=0; row<dataArray.length; row++) {
    fill(50,50,200);
    noStroke();
    float x = map(row, 0,dataArray.length, 0,width);
    rect(x,0, width/dataArray.length,map(dataArray[row][columnArrayIdx], 0,columnMaxArray, 0,height));
  }
}

void drawGenderBreakdownUsingTable() {
  int rowCount = 0;
  for(TableRow row : dataTable.rows()) {
    fill(255);
    noStroke();
    float x = map(rowCount, 0,dataTable.getRowCount(), 0,width);
    rect(x,0, width/dataTable.getRowCount(),map(row.getInt(columnLabel), 0,columnMaxTable, 0,height));
    rowCount++;
  }
}
