import java.util.Map;

class CollisionSystem {
  ArrayList<Particle> parts;
  
  public CollisionSystem(int num, float rad) {
    parts = new ArrayList<Particle>();
    while(parts.size() < num) {
      Particle p = new Particle(new PVector(random(rad*2,width-rad*2),random(rad*2,height-rad*2)), rad);
      boolean isect = false;
      for(Particle other : parts) {
        if(p.intersect(other)) {
          isect = true;
          break;
        }
      }
      if(!isect) {
        parts.add(p);
      }
    }
  }
  
  public CollisionSystem(int num) {
    this(num,5);
  }
  
  public void runWithWallIntersections(ArrayList<FixedWall> walls) {
    for(Particle p : parts) {
      boolean isect = false;
      for(FixedWall w : walls) {
        isect = isect || p.intersect(w);
      }
      if(isect) fill(0,255,255);
      else fill(0);
      p.run();
    }
  }
  
  public void runWithIntersections() {
    for(Particle p : parts) {
      boolean isect = false;
      for(Particle q : parts) {
        if(p != q) {
          isect = isect || p.intersect(q);
        }
      }
      if(isect) fill(255,0,0);
      else fill(0);
      p.run();
    }
  }
  
  public void runShowingParticleCollisions() {
    for(Particle p : parts) {
      float timeToIntersect = 100;
      for(Particle q : parts) {
        if(p != q) {
          float tti = p.getCollisionTime(q);
          if(tti >= 0 && tti < timeToIntersect)
            timeToIntersect = tti;
        }
      }
      fill(map(timeToIntersect,0,100,255,0),0,0);
      if(timeToIntersect < 1) fill(0,0,255);
      p.run();
    }
  }
  
  public void runWithParticleCollisions() {
    float closestIntersection = 1000;
    boolean collisionHappened = true;
    HashMap<Particle,Float> collided = new HashMap<Particle,Float>();
    float timeRemaining = 1f;
    while(collisionHappened && timeRemaining > 0) {
      collisionHappened = false;
      closestIntersection = 1000;
      Particle closest1 = null;
      Particle closest2 = null;
      for(Particle p : parts) {
        float timeToIntersect = 1000;
        for(Particle q : parts) {
          if(p != q && !p.intersect(q)) {
            float tti = p.getCollisionTime(q);
            if(tti >= 0 && tti < timeToIntersect)
              timeToIntersect = tti;
            if(timeToIntersect < closestIntersection) {
              closestIntersection = timeToIntersect;
              closest1 = p;
              closest2 = q;
            }
          }
        }
      }
      if(closest1 != null && closest2 != null && closestIntersection <= timeRemaining) {
        for(Particle p : parts) {
          p.update(closestIntersection);
        }
        collided.put(closest1,closestIntersection);
        collided.put(closest2,closestIntersection);
        closest1.performCollision(closest2);
        timeRemaining -= closestIntersection;
        collisionHappened = true;
      }
    }
    
    for(Particle p : parts) {
      if(collided.containsKey(p)) {
        fill(255,0,0);
      } else {
        fill(0);
      }
      p.run(timeRemaining);
    }
  }
  
  public void runShowingWallCollisions(ArrayList<FixedWall> walls) {
    for(Particle p : parts) {
      float timeToIntersect = 10000;
      for(FixedWall w : walls) {
        float tti = p.getCollisionTime(w);
        if(tti >= 0 && tti < timeToIntersect)
          timeToIntersect = tti;
      }
      println(timeToIntersect);
      fill(map(timeToIntersect,0,100,255,0),0,0);
      if(timeToIntersect < 1) fill(0,0,255);
      p.run();
    }
  }
  
  public void runWithWallCollisions(ArrayList<FixedWall> walls) {
    float nextWallIsect = 1000;
    boolean collisionHappened = true;
    float timeRemaining = 1f;
    
    while(collisionHappened && timeRemaining > 0) {
      collisionHappened = false;
      nextWallIsect = 1000;
      
      //Find the next wall intersection
      FixedWall nextWall = null;
      Particle nextWallPart = null;
      for(Particle p : parts) {
        for(FixedWall w : walls) {
          if(!p.intersect(w)) {
            float tti = p.getCollisionTime(w);
            if(tti >= 0 && tti < nextWallIsect) {
              nextWallIsect = tti;
              nextWall = w;
              nextWallPart = p;
            }
          }
        }
      }
      
      //Perform the next intersection
      if(nextWall != null && nextWallPart != null && nextWallIsect <= timeRemaining) {
        for(Particle p : parts) {
          p.update(nextWallIsect);
        }
        nextWallPart.performCollision(nextWall);
        timeRemaining -= nextWallIsect;
        collisionHappened = true;
      }
    }
    
    //After all the collisions this frame are handled, run the particles
    //the rest of the remaining time in this frame
    for(Particle p : parts) {
      p.run(timeRemaining);
    }
  }
  
  public void runWithParticleAndWallCollisions(ArrayList<FixedWall> walls) {
    float nextPartIsect = 1000;
    float nextWallIsect = 1000;
    boolean collisionHappened = true;
    float timeRemaining = 1f;
    
    while(collisionHappened && timeRemaining > 0) {
      collisionHappened = false;
      nextPartIsect = 1000;
      nextWallIsect = 1000;
      
      //Find the next particle intersection
      Particle nextPart1 = null;
      Particle nextPart2 = null;
      for(Particle p : parts) {
        for(Particle q : parts) {
          if(p != q && !p.intersect(q)) {
            float tti = p.getCollisionTime(q);
            if(tti >= 0 && tti < nextPartIsect) {
              nextPartIsect = tti;
              nextPart1 = p;
              nextPart2 = q;
            }
          }
        }
      }
      
      //Find the next wall intersection
      FixedWall nextWall = null;
      Particle nextWallPart = null;
      for(Particle p : parts) {
        for(FixedWall w : walls) {
          if(!p.intersect(w)) {
            float tti = p.getCollisionTime(w);
            if(tti >= 0 && tti < nextWallIsect) {
              nextWallIsect = tti;
              nextWall = w;
              nextWallPart = p;
            }
          }
        }
      }
      
      //If the next collision is particle-particle
      if(nextPartIsect < nextWallIsect) {
        if(nextPart1 != null && nextPart2 != null && nextPartIsect <= timeRemaining) { 
          for(Particle p : parts) {
            p.update(nextPartIsect);
          }
          nextPart1.performCollision(nextPart2);
          timeRemaining -= nextPartIsect;
          collisionHappened = true;
        }
      }
      //Otherwise, the next collision may be particle-wall
      else {
        if(nextWall != null && nextWallPart != null && nextWallIsect <= timeRemaining) {
          for(Particle p : parts) {
            p.update(nextWallIsect);
          }
          nextWallPart.performCollision(nextWall);
          timeRemaining -= nextWallIsect;
          collisionHappened = true;
        }
      }
    }
    
    //After all the collisions this frame are handled, run the particles
    //the rest of the remaining time in this frame
    for(Particle p : parts) {
      p.run(timeRemaining);
    }
  }
  
  
  public void run() {
    for(Particle p : parts) {
      p.run();
    }
  }
  
}
