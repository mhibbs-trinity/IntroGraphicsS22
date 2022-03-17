PImage img;
PImage gimg;
PImage copy;
PImage rboy;
PImage[] frames;
float[][] kernel;

/*
void settings() {
  //img = loadImage("SundayInPark.jpg");
  img = loadImage("alamo.png");
  //img = loadImage("balloons.png");
  //img = loadImage("city.png");
  //img = loadImage("MTower.jpg");
  //img = loadImage("orion.png");
  //img = loadImage("PearlEarring.jpg");
  //img = loadImage("riverwalk.png");
  //gimg = loadImage("green_bike.jpg");
  gimg = loadImage("green_dude.jpg");
  //img = loadImage("robotBoy_run.jpg");
  size(img.width,img.height);
}*/

void setup() {
  //img = loadImage("SundayInPark.jpg");
  img = loadImage("alamo.png");
  //img = loadImage("balloons.png");
  //img = loadImage("city.png");
  //img = loadImage("MTower.jpg");
  //img = loadImage("orion.png");
  //img = loadImage("PearlEarring.jpg");
  //img = loadImage("riverwalk.png");
  //gimg = loadImage("green_bike.jpg");
  gimg = loadImage("green_dude.jpg");
  //img = loadImage("robotBoy_run.jpg");
  size(1000,1000);
  //copy = grayScale(img);
  //copy = tintRed(img);
  //copy = rotateColors(img);
  //copy = greenScreen(img, gimg);
  //copy = simpleBlur(img);
  //copy = simpleEdge(img);
  /*
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
  copy = convolve(img, blur7);
  amt = 1f/5f;
  float[][] diagBlur={{amt,0,0,0,0},
                      {0,amt,0,0,0},
                      {0,0,amt,0,0},
                      {0,0,0,amt,0},
                      {0,0,0,0,amt}};
  copy = convolve(img, diagBlur); */
  kernel = diagMotionBlur(15);
  copy = convolve(img, kernel);
  
  loadRobot();
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

float bound(float num) {
  if(num < 0) return 0;
  else if(num > 255) return 255;
  else return num;
}

void loadRobot() {
  rboy = loadImage("robotBoy_run.png");
  frames = new PImage [16];
  int ctr = 0;
  for(int y=0; y<rboy.height-100; y = y+275) {
    for(int x=0; x<rboy.width-100; x = x+275) {
      if(ctr < 16) {
        frames[ctr] = rboy.get(x,y, 275,275);
        ctr++;
      } 
    }
  }
  frameRate(15);
}

PImage simpleBlur(PImage img) {
  img.loadPixels();
  PImage modImg = createImage(img.width,img.height,RGB);
  modImg.loadPixels();
  for(int x=1; x<img.width-1; x++) {
    for(int y=1; y<img.height-1; y++) {
      color mid = img.pixels[y*img.width + x];
      color left = img.pixels[y*img.width + x-1];
      color right = img.pixels[y*img.width + x+1];
      color up = img.pixels[(y-1)*img.width + x];
      color down = img.pixels[(y+1)*img.width + x];
      
      modImg.pixels[y*img.width + x] = color(
        (red(mid) + red(left) + red(right) + red(up) + red(down)) / 5,
        (green(mid) + green(left) + green(right) + green(up) + green(down)) / 5,
        (blue(mid) + blue(left) + blue(right) + blue(up) + blue(down)) / 5); 
    }
  }
  modImg.updatePixels();
  return modImg;
}

PImage simpleEdge(PImage img) {
  img.loadPixels();
  PImage modImg = createImage(img.width,img.height,RGB);
  modImg.loadPixels();
  for(int x=1; x<img.width-1; x++) {
    for(int y=1; y<img.height-1; y++) {
      color mid = img.pixels[y*img.width + x];
      color lr = img.pixels[(y+1)*img.width + x+1];
      if(brightness(mid) - brightness(lr) > 20) {
        modImg.pixels[y*img.width + x] = color(255);
      }
    }
  }
  modImg.updatePixels();
  return modImg;
}

PImage greenScreen(PImage img, PImage gimg) {
  PImage copy = createImage(gimg.width,gimg.height,RGB);
  img.loadPixels();
  copy.loadPixels();
  gimg.loadPixels();
  for(int x=0; x<gimg.width; x++) {
    for(int y=0; y<gimg.height; y++) {
      color bgcol = img.pixels[y*img.width + x];
      color gscol = gimg.pixels[y*gimg.width + x];
      if(green(gscol) > red(gscol) && green(gscol) > blue(gscol) && green(gscol) > 100) {
        copy.pixels[y*gimg.width + x] = bgcol;
      } else {
        copy.pixels[y*gimg.width + x] = gscol;
      }
    }
  }
  copy.updatePixels();
  return copy;
}

void randomCircles(PImage img) {
  int x = int(random(width));
  int y = int(random(height));
  img.loadPixels();
  color c = img.pixels[y*width + x];
  fill(c);
  noStroke();
  ellipse(x,y, 20,20);
}

void spotlight(PImage img) {
  img.loadPixels();
  loadPixels();
  for(int x=0; x<width; x++) {
    for(int y=0; y<height; y++) {
      /*
      if(dist(x,y, mouseX,mouseY) < 100) {
        pixels[y*width + x] = img.pixels[y*width + x];
      } else {
        pixels[y*width + x] = color(0);
      }*/
      pixels[y*width + x] = lerpColor(img.pixels[y*width+x], color(0), map(dist(x,y, mouseX,mouseY), 0,200, 0,1));
    }
  }
  updatePixels();
}

PImage rotateColors(PImage img) {
  PImage copy = createImage(img.width,img.height,RGB);
  img.loadPixels();
  copy.loadPixels();
  for(int i=0; i<img.pixels.length; i++) {
    color c = (color)img.pixels[i];
    copy.pixels[i] = color(blue(c), red(c), green(c));
  }
  copy.updatePixels();
  return copy;
}

PImage tintRed(PImage img) {
  PImage copy = createImage(img.width,img.height,RGB);
  img.loadPixels();
  copy.loadPixels();
  for(int i=0; i<img.pixels.length; i++) {
    color c = (color)img.pixels[i];
    copy.pixels[i] = color(red(c)+50, green(c), blue(c));
  }
  copy.updatePixels();
  return copy;
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

int curr = 0;

void draw() {
  background(0);
  
  if(keyPressed) {
    image(img, 0,0);
  } else {
    image(copy,0,0);
  }
  //spotlight(img);
  //for(int i=0; i<50; i++) randomCircles(img);
  /* Robot animation 
  image(frames[curr], mouseX,mouseY);
  curr++;
  if(curr >= frames.length) {
    curr = 0;
  }
  */
}
