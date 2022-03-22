
PImage img;
PImage copy;

void setup() {
  img = loadImage("SundayInPark.jpg");
  copy = createImage(img.width, img.height, RGB);
  
  //simpleBlur();
  
  float amt = 1f/9f;
  float[][] blur3 = {{amt,amt,amt},
                     {amt,amt,amt},
                     {amt,amt,amt}};
  //copy = convolve(img, blur3);
  copy = convolve(img, squareBlur(45));
  
  size(800,800);
}

float[][] squareBlur(int sz) {
  float amt = 1f / (sz*sz);
  float[][] k = new float[sz][sz];
  for(int i=0; i<sz; i++) {
    for(int j=0; j<sz; j++) {
      k[i][j] = amt;
    }
  }
  return k;
}

PImage convolve(PImage img, float[][] kernel) {
  PImage res = createImage(img.width, img.height, RGB);
  img.loadPixels();
  res.loadPixels();
  
  int ox = kernel.length / 2;
  int oy = kernel[0].length / 2;
  
  for(int x=ox; x<img.width-ox; x++) {
    for(int y=oy; y<img.height-oy; y++) {
      float r = 0;
      float g = 0;
      float b = 0;
      for(int kx=0; kx<kernel.length; kx++) {
        for(int ky=0; ky<kernel[0].length; ky++) {
          color c = img.pixels[(y-oy+ky)*img.width + (x-ox+kx)];
          r += red(c) * kernel[kx][ky];
          g += green(c) * kernel[kx][ky];
          b += blue(c) * kernel[kx][ky];
        }
      }
      res.pixels[y*img.width + x] = color(r,g,b);
    }
  }
 
  res.updatePixels();
  return res;
}


void simpleBlur() {
  img.loadPixels();
  copy.loadPixels(); 
  for(int i=0; i<img.pixels.length; i++) {
    int r=0;
    int g=0;
    int b=0;
    for(int ox=-9; ox<=9; ox++) {
      //for(int oy=-3; oy<=3; oy++) {
        int idx = ((i/img.width)+ox) * img.width + (i%img.width + ox);
        int yoff = idx/img.width+ox;
        int xoff = idx%img.width + ox;
        if(xoff < 0) xoff = 0;
        if(xoff >= img.width) xoff = img.width-1;
        if(yoff < 0) yoff = 0;
        if(yoff >= img.height) yoff = img.height -1;
        color oc = img.pixels[yoff * img.width + xoff];
        r += red(oc);
        g += green(oc);
        b += blue(oc);
      //}
    }
    copy.pixels[i] = color(r/19,g/19,b/19);
  }
  img.updatePixels();
  copy.updatePixels();
}


void draw() {
  /*
  for(int i=0; i<100; i++) {
    int x = int(random(img.width));
    int y = int(random(img.height));
    color c = img.pixels[y*img.width + x];
    fill(c);
    stroke(c);
    line(x,y, x+5,y+5);
  }*/
  
  if(keyPressed) {
    image(copy, 0,0);
  } else {
    image(img, 0,0);
  }
}
