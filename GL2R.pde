class GL2R {
  //拡大縮小の行列を管理する
  float a, b, c, d;
  GL2R() {
  }
  GL2R(float _a, float _b, float _c, float _d) {
    a=_a;
    b=_b;
    c=_c;
    d=_d;
  }
  boolean isGL2R() {
    if (a*d-b*c!=0) return true;
    else return false;
  }
  PVector moveByMatrix(PVector v) {
    return new PVector(a*v.x+b*v.y, c*v.x+d*v.y);
  }
  Path moveByMatrix(Path p) {
    Path q = new Path();
    for (int j=0; j<p.size(); j++) {
      q.addPVector(moveByMatrix(p.get(j)));
    }
    return q;
  }
}


GL2R prod(GL2R f, GL2R g) {
  return new GL2R(
    f.a*g.a+f.b*g.c, f.a*g.b+f.b*g.d, 
    f.c*g.a+f.d*g.c, f.c*g.b+f.d*g.d);
}