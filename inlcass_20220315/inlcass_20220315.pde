
PImage img;
PImage copy;

void setup() {
  img = loadImage("SundayInPark.jpg");
  copy = createImage(img.width, img.height, RGB);
  
  simpleBlur();
  size(800,800);
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
  if(keyPressed) {
    image(copy, 0,0);
  } else {
    image(img, 0,0);
  }
}
