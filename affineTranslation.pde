path[] p ;
path[] q ;

GL2R f=new GL2R(
 1,-2,1,1
);

GL2R g=new GL2R(
 1,2,1,-1
);

plane myp;

void setup() {
  size(800, 800);
  myp=new plane();
  p = new path[4];
  for (int i=0; i<4; i++) {
    p[i] = new path();
  }
  /// FMS!
  p[0].addPVector(new PVector(0, 0));
  p[0].addPVector(new PVector(0, 1));
  p[0].addPVector(new PVector(1, 1));
  p[1].addPVector(new PVector(0, 0.5));
  p[1].addPVector(new PVector(0.8, 0.5));
  p[2].addPVector(new PVector(1.1, 0));
  p[2].addPVector(new PVector(1.1, 1));
  p[2].addPVector(new PVector(1.6, 0.5));
  p[2].addPVector(new PVector(2.1, 1));
  p[2].addPVector(new PVector(2.1, 0));
  p[3].addPVector(new PVector(3.2, 1));
  p[3].addPVector(new PVector(2.2, 1));
  p[3].addPVector(new PVector(2.2, 0.5));
  p[3].addPVector(new PVector(3.2, 0.5));
  p[3].addPVector(new PVector(3.2, 0));
  p[3].addPVector(new PVector(2.2, 0));

  q = new path[4];
}

void draw() {
  
  //GL2R h = prod(f,g);
  GL2R h = prod(g,f);
  println(h.a,h.b,h.c,h.d);
  
  
  background(0);
  myp.drawAxis();
  stroke(200,200,255);
  strokeWeight(3);
  // draw 'FMS'
  for (int i=0; i<4; i++) {
    p[i].drawPath();
  }
  // move letters by a matrix
  for (int i=0; i<4; i++) {
    q[i] = h.moveByMatrix(p[i]);
  }
  // draw new letters
  stroke(255,128,128);
  strokeWeight(3);
  for (int i=0; i<4; i++) {
    q[i].drawPath();
  }
}