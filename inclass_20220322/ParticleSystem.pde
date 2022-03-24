
class ParticleSystem {
  ArrayList<Particle> parts;
  PVector origin;
  
  ParticleSystem(PVector o) {
    origin = o.copy();
    parts = new ArrayList<Particle>();
  }
  
  void run() {
    parts.add(new Particle(origin));
    for(int i=parts.size() - 1; i>=0; i--) {
      parts.get(i).applyForce(new PVector(0,0.1));
      parts.get(i).update();
      parts.get(i).display();
      if(parts.get(i).lifespan < 0) {
        parts.remove(i);
      }
    }
    
  }
}
