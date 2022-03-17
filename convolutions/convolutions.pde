PImage img;
PImage copy;
float[][] kernel;

void setup() {
  //img = loadImage("SundayInPark.jpg");
  //img = loadImage("alamo.png");
  img = loadImage("balloons.png");
  //img = loadImage("city.png");
  //img = loadImage("MTower.jpg");
  //img = loadImage("orion.png");
  //img = loadImage("PearlEarring.jpg");
  //img = loadImage("riverwalk.png");
  size(1000,1000);
  
  float amt = 1f/25f;
  float[][] blur5 = {{amt,amt,amt,amt,amt},
                     {amt,amt,amt,amt,amt},
                     {amt,amt,amt,amt,amt},
                     {amt,amt,amt,amt,amt},
                     {amt,amt,amt,amt,amt}};
  amt = 1f/49f;
  float[][] blur7 = {{amt,amt,amt,amt,amt,amt,amt},
                     {amt,amt,amt,amt,amt,amt,amt},
                     {amt,amt,amt,amt,amt,amt,amt},
                     {amt,amt,amt,amt,amt,amt,amt},
                     {amt,amt,amt,amt,amt,amt,amt},
                     {amt,amt,amt,amt,amt,amt,amt},
                     {amt,amt,amt,amt,amt,amt,amt}};
  amt = 1f/5f;
  float[][] diagBlur={{amt,0,0,0,0},
                      {0,amt,0,0,0},
                      {0,0,amt,0,0},
                      {0,0,0,amt,0},
                      {0,0,0,0,amt}};
  //copy = convolve(img, blur5);                      
  //copy = convolve(img, blur7);                      
  //copy = convolve(img, diagBlur);
  //copy = convolve(img, diagMotionBlur(21));
  //copy = convolve(img, motionBlur(51,new PVector(1,5)));
  
  //copy = convolve(img, squareBlur(11));
  //copy = convolve(convolve(img, squareBlur(3)), horizEdge(5));
  //copy = convolve(img, vertEdge(5));
  //copy = convolve(img, allEdge(3));
  //copy = convolve(img, sharpen(3));
  copy = bias(grayScale(convolve(img, emboss(5))), 128);
  
}

float[][] diagMotionBlur(int sz) {
  float[][] k = new float[sz][sz];
  for(int i=0; i<sz; i++) {
    for(int j=0; j<sz; j++) {
      if(i==j) k[i][j] = 1f/sz;
    }
  }
  return k;
}

PImage convolve(PImage img, float[][] kernel) {
  img.loadPixels();
  PImage modImg = createImage(img.width, img.height, RGB);
  modImg.loadPixels();
  
  int ox = kernel.length/2;
  int oy = kernel[0].length/2;
  
  for(int x=ox; x<img.width-ox; x++) {
    for(int y=oy; y<img.height-oy; y++) {
      float r = 0;
      float g = 0;
      float b = 0;
      for(int kx=0; kx<kernel.length; kx++) {
        for(int ky=0; ky<kernel[0].length; ky++) {
          color c = img.pixels[(y-oy+ky)*img.width + (x-ox+kx)];
          r += red(c)*kernel[kx][ky];
          g += green(c)*kernel[kx][ky];
          b += blue(c)*kernel[kx][ky];
        }
      }
      modImg.pixels[y*img.width+x] = color(bound(r),bound(g),bound(b));
    }
  }
  modImg.updatePixels();
  return modImg;
}

float[][] emboss(int rows) {
  float[][] k = new float[rows][rows];
  for(int i=0; i<rows; i++) {
    for(int j=0; j<rows; j++) {
      if(j<i) k[i][j] = -1;
      else if(j==i) k[i][j] = 0;
      else k[i][j] = 1;
      print(k[i][j] + "  ");
    }
    println();
  }
  return k;
}

PImage bias(PImage img, float amt) {
  img.loadPixels();
  PImage modImg = createImage(img.width,img.height,RGB);
  modImg.loadPixels();
  for(int i=0; i<img.pixels.length; i++) {
    color c = img.pixels[i];
    modImg.pixels[i] = color(bound(red(c)+amt),bound(green(c)+amt),bound(blue(c)+amt));
  }
  modImg.updatePixels();
  return modImg;
}

float[][] horizEdge(int cols) {
  float[][] k = new float[1][cols];
  for(int i=0; i<cols; i++) {
    k[0][i] = -1;
  }
  k[0][cols/2] = cols-1;
  //println(k[0][0] + ":" + k[0][1] + ":" + k[0][2] + ":" + k[0][3] + ":" + k[0][4]);
  return k;
}
float[][] vertEdge(int rows) {
  float[][] k = new float[rows][1];
  for(int i=0; i<rows; i++) {
    k[i][0] = -1;
  }
  k[rows/2][0] = rows-1;
  println(k[0][0] + ":" + k[1][0] + ":" + k[2][0] + ":" + k[3][0] + ":" + k[4][0]);
  return k;
}
float[][] allEdge(int rows) {
  float[][] k = new float[rows][rows];
  for(int i=0; i<rows; i++) {
    for(int j=0; j<rows; j++) {
      k[i][j] = -1;
    }
  }
  k[rows/2][rows/2] = (rows*rows) - 1;
  return k;
}
float[][] sharpen(int rows) {
  float[][] k = new float[rows][rows];
  for(int i=0; i<rows; i++) {
    for(int j=0; j<rows; j++) {
      k[i][j] = -1;
    }
  }
  k[rows/2][rows/2] = (rows*rows);
  return k;
}

float[][] normalizeKernel(float[][] k) {
  float sum = 0;
  for(int i=0; i<k.length; i++) {
    for(int j=0; j<k[i].length; j++) {
      sum += k[i][j];
    }
  }
  for(int i=0; i<k.length; i++) {
    for(int j=0; j<k[i].length; j++) {
      k[i][j] /= sum;
    }
  }
  return k;
}
float[][] pixelsToKernel(int[] pix, int rows) {
  float[][] k = new float[rows][pix.length/rows];
  for(int i=0; i<k.length; i++) {
    for(int j=0; j<k[i].length; j++) {
      k[i][j] = brightness(pix[j*k.length + i]);
    }
  }
  return normalizeKernel(k);
}

float[][] squareBlur(int rows) {
  float[][] k = new float[rows][rows];
  for(int i=0; i<rows; i++) {
    for(int j=0; j<rows; j++) {
      k[i][j] = 1.0 / (rows*rows);
    }
  }
  return k;
}

float[][] gaussBlur(int rows) {
  float[][] k = new float[rows][rows];
  return k;
}


float[][] motionBlur(int rows, PVector direction) {
  direction.div(direction.mag());
  PGraphics pg = createGraphics(rows,rows);
  pg.beginDraw();
  pg.noSmooth();
  pg.background(0);
  pg.translate(rows/2,rows/2);
  pg.stroke(255);
  pg.line(0,0, rows*direction.x,rows*direction.y);
  pg.line(0,0, -rows*direction.x,-rows*direction.y);
  pg.endDraw();
  pushMatrix();
  scale(4);
  image(pg,0,0);
  popMatrix();
  return pixelsToKernel(pg.pixels, rows);
}

PImage grayScale(PImage img) {
  PImage copy = createImage(img.width,img.height,RGB);
  img.loadPixels();
  copy.loadPixels();
  for(int i=0; i<img.pixels.length; i++) {
    color c = (color)img.pixels[i];
    //float avg = (red(c) + blue(c) + green(c)) / 3.0;
    copy.pixels[i] = color(brightness(c));//avg,avg,avg);
  }
  copy.updatePixels();
  return copy;
}

float bound(float num) {
  if(num < 0) return 0;
  else if(num > 255) return 255;
  else return num;
}


int curr = 0;

void draw() {
  background(0);
  
  if(!keyPressed) {
    image(img, 0,0);
  } else {
    image(copy,0,0);
  }
  
}
