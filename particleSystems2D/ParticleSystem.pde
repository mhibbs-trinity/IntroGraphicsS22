class ParticleSystem {
  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;                   // An origin point for where particles are birthed
  
  ParticleSystem(int num, PVector v) {
    particles = new ArrayList<Particle>();              // Initialize the arraylist
    origin = v.copy();                                   // Store the origin point
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin));         // Add "num" amount of particles to the arraylist
    }
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      if (p.isDead()) {
        particles.remove(i);
      } else {
        p.run();
      }
    }
  }
  
  // Method to add a force vector to all particles currently in the system
  void applyForce(PVector dir) {
    for (Particle p: particles) {
      p.applyForce(dir);
    }
  }  

  void addParticle() {
    addParticle(new Particle(origin));
  }
  
  void addParticle(Particle p) {
    p.loc = origin.copy();
    particles.add(p);
  }

}
