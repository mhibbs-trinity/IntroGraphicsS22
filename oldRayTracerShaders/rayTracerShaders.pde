PShader raytrace;
PImage img;
float time;
PImage scn;
float numBufs;
PGraphics buf;

int sz = 500;

/* MODE:
 * 1 - most basic ray tracer with shadows
 * 2 - specularity & refraction
 * 3 - soft shadows & anti-aliasing
 */
int mode = 0;

void setup() {
  //frameRate(5);
  size(500,500,P3D);
  resetup();
}

void resetup() {
  img = loadImage("gray.png");
  if(mode == 0) {
    raytrace = loadShader("frag_Sphere.glsl","rayTraceVert.glsl");
  }
  if(mode == 1) {
    raytrace = loadShader("rtfrag.glsl","rtvert.glsl");
  }
  if(mode == 2) {
    raytrace = loadShader("rtfragbounce.glsl","rtvertbounce.glsl");
  }
  if(mode == 3) {
    raytrace = loadShader("rtfragsample.glsl","rtvertsample.glsl");
  }
  time = 0;
  scn = createImage(sz,sz,ARGB);
  numBufs = 0;
  buf = createGraphics(sz,sz,P3D);
}

void keyPressed() {
  if(key >= '0' && key <= '9') {
    mode = int(key - '0');
    resetup();
  }
}

void avgInBuffer() {
  if(numBufs == 0.0) {
    scn.pixels = buf.pixels;
  } else {
    buf.loadPixels();
    scn.loadPixels();
    for(int i=0; i<scn.pixels.length; i++) {     
      scn.pixels[i] = color( (  red(scn.pixels[i])*numBufs +   red(buf.pixels[i])) / (numBufs+1),
                             (green(scn.pixels[i])*numBufs + green(buf.pixels[i])) / (numBufs+1),
                             ( blue(scn.pixels[i])*numBufs +  blue(buf.pixels[i])) / (numBufs+1));
    }
    scn.updatePixels(); 
  }
  numBufs++;
} 



void draw() {
  background(0);
  
  buf.beginDraw();
  buf.background(0);
  
  if(mode == 3) {
    raytrace.set("litOffX",random(2.0));
    raytrace.set("litOffY",random(2.0));
    raytrace.set("litOffZ",random(2.0));
    raytrace.set("camOffX",random(0.05));
    raytrace.set("camOffY",random(0.05));
    raytrace.set("camOffZ",random(0.05));  
  }
  
  raytrace.set("time",time);
  time += PI/128;
  
  buf.shader(raytrace);

  buf.textureMode(NORMAL);
  buf.beginShape(QUADS);
  buf.texture(img);
  buf.vertex( 0, 0,0, 0,0);
  buf.vertex(sz, 0,0, 1,0);
  buf.vertex(sz,sz,0, 1,1);
  buf.vertex( 0,sz,0, 0,1);
  buf.endShape();
  
  buf.endDraw();
  
  if(mode <= 2) {
    image(buf,0,0);
  }
  if(mode == 3) {
    avgInBuffer();
    image(scn,0,0);
  }
}
