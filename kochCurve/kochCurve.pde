/* Modified from Daniel Shiffman's book "The Nature of Code"
 */

class Koch {
  PVector begin;
  PVector end;
  
  Koch(PVector b, PVector e) {
    begin = b;
    end = e;
  }
  void display() {
    stroke(255);
    line(begin.x,begin.y, end.x,end.y);
  }
  PVector getA() { return begin; }
  PVector getB() {
    PVector v = PVector.sub(end,begin);
    v.div(3);
    v.add(begin);
    return v;
  }
  PVector getC() {
    PVector a = begin.get();
    PVector v = PVector.sub(end,begin);
    v.div(3);
    a.add(v);
    v.rotate(-PI/3);
    a.add(v);
    return a;
  }
  PVector getD() {
    PVector v = PVector.sub(end,begin);
    v.mult(2.0/3);
    v.add(begin);
    return v;
  }
  PVector getE() { return end; }
}

ArrayList<Koch> lines;

void generate() {
  ArrayList<Koch> nextList = new ArrayList<Koch>();
  for(Koch l : lines) {
    PVector a = l.getA();
    PVector b = l.getB();
    PVector c = l.getC();
    PVector d = l.getD();
    PVector e = l.getE();
    nextList.add(new Koch(a,b));
    nextList.add(new Koch(b,c));
    nextList.add(new Koch(c,d));
    nextList.add(new Koch(d,e));
  }
  lines = nextList;
}

void setup() {
  size(500,500);
  lines = new ArrayList<Koch>();
  PVector p1 = new PVector(100,350);
  PVector p3 = new PVector(400,350);
  PVector p2 = PVector.sub(p3,p1);
  p2.rotate(-PI/3);
  p2.add(p1);
  lines.add(new Koch(p1,p2));
  lines.add(new Koch(p2,p3));
  lines.add(new Koch(p3,p1));
  //lines.add(new Koch(new PVector(0,300), new PVector(width,300)));
}

void draw() {
  background(0);
  for(Koch l : lines) {
    l.display();
  }
}

void mouseClicked() {
  generate();
}
