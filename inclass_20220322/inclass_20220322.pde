
ParticleSystem p = new ParticleSystem(new PVector(200,200));

void setup() {
  size(500,500); 
}

void draw() {
  background(255);
  p.run();
}

void mouseClicked() {
  p = new ParticleSystem(new PVector(mouseX, mouseY)); 
}
