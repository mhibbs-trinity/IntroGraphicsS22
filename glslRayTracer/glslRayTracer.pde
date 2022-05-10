
PShader shade;
PImage img; //dummy image required to get texture coordinates
PImage sphTexture;
PVector camPos;

enum Mode { TEXCOORD, SIMPLE, PLANES, PLANESHADOW, MULTISPHERE, ANTIALIAS, REFLECTIONS };
Mode mode = Mode.TEXCOORD;
HashMap<Character, Mode> keyMap;
void keyPressed() {
  if(keyMap.containsKey(key)) { mode = keyMap.get(key); }
  resetup();
}

void setup() {
  size(800,800,P3D);
  
  //Setup the key mapping for modes
  keyMap = new HashMap<Character, Mode>();
  keyMap.put('t',Mode.TEXCOORD);
  keyMap.put(' ',Mode.SIMPLE);
  keyMap.put('m',Mode.MULTISPHERE);
  keyMap.put('p',Mode.PLANES);
  keyMap.put('s',Mode.PLANESHADOW);
  keyMap.put('a',Mode.ANTIALIAS);
  keyMap.put('r',Mode.REFLECTIONS);

  //Making the dummy image
  img = createImage(1,1,RGB);
  img.loadPixels();
  img.pixels[0] = color(255,255,0);
  img.updatePixels();
  
  //Load texture images
  //sphTexture = loadImage("stripes.png");
  //sphTexture = loadImage("venus.jpg");
  //sphTexture = loadImage("grid.png");
  sphTexture = loadImage("swirl.png");
  
  //Setup the initial camera position
  camPos = new PVector(0,0,5);
  
  //Load the right shader based on the mode variable
  resetup();
}

void resetup() {
  if(mode == Mode.TEXCOORD) {
    shade = loadShader("texCoordsFrag.glsl","rtvert.glsl");  
  }
  if(mode == Mode.SIMPLE) {
    shade = loadShader("simpleSphere.glsl","rtvert.glsl");
    shade.set("sphTex", sphTexture);
  }
  if(mode == Mode.PLANES) {
    shade = loadShader("simplePlanes.glsl","rtvert.glsl");
    //shade.set("sphTex", sphTexture);
  }
  if(mode == Mode.PLANESHADOW) {
    shade = loadShader("sphereAndPlaneShadow.glsl","rtvert.glsl");
    shade.set("sphTex", sphTexture);
  }
  if(mode == Mode.MULTISPHERE) {
    shade = loadShader("multiSpheresAndPlanes.glsl","rtvert.glsl");
    shade.set("sphTex", sphTexture);
  }
  if(mode == Mode.ANTIALIAS) {
    shade = loadShader("antialiasedScene.glsl","rtvert.glsl");
    shade.set("sphTex", sphTexture);
  }
  if(mode == Mode.REFLECTIONS) {
    shade = loadShader("reflections.glsl","rtvert.glsl");
    shade.set("sphTex", sphTexture);
  }
  
}

void draw() {
  background(0);
  if(keyPressed && keyCode == ALT) { drawUsage(); }
  else {
    PVector litPos = new PVector(map(mouseX, 0,width,  -1.9,1.9),
                                 map(mouseY, 0,height, -1.9,1.9),
                                 -10);
    shade.set("litPos", litPos);
    if(mousePressed) {
      camPos = new PVector(map(mouseX, 0,width, -1,1),
                           map(mouseY, 0,height,-1,1),
                           5);
    }
    shade.set("camPos", camPos);
    
    int numRands = 10;
    float[] rands = new float[numRands];
    for(int i=0; i<numRands; i++) {
      rands[i] = random(1f);
    }
    shade.set("rands", rands);
    
    shader(shade);
    textureMode(NORMAL);
    beginShape(QUADS);
    texture(img);
    vertex(  0,  0,0, 0,0);
    vertex(800,  0,0, 1,0);
    vertex(800,800,0, 1,1);
    vertex(  0,800,0, 0,1);
    endShape();
  }
}

void drawUsage() {
  background(255);
  resetShader();
  textFont(createFont("SansSerif", 40));
  fill(0);
  text("Mode Options:", 50,50);
  float y = 100;
  for(char k : keyMap.keySet()) {
   text(k + ": " + keyMap.get(k).toString(), 50,y);
   y += 50;
  }
}
