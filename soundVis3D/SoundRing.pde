class SoundRing {
  float[] waves;
  float r;
  float z;
  color c;
  
  SoundRing(float[] w, color col, float radius) {
    waves = w;
    r = radius;
    z = 0;
    c = col;
  }
  
  void display() {
    stroke(c);
    strokeWeight(2);
    float stepSz = 2.0*PI / waves.length;
    float step = 0;
    float o = waves[waves.length-1] * r/2.0;
    float no = waves[0] * r/2.0;
    line((r+o)*cos(-stepSz), (r+o)*sin(-stepSz), z,
         (r+no)*cos(step), (r+no)*sin(step), z);
    for(int i=0; i<waves.length-1; i++) {
      o = waves[i] * r/2.0;
      no = waves[i+1] * r/2.0;
      line((r+o)*cos(step), (r+o)*sin(step), z,
           (r+no)*cos(step+stepSz), (r+no)*sin(step+stepSz), z);
      step += stepSz;
    }
    
  }
  
  void moveBack() {
    z -= 10;
    c = color(red(c),green(c),blue(c),alpha(c)-5);
  }
}
           
