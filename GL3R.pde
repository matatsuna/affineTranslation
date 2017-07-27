class GL3R 
{
  //拡大縮小の行列を管理する
  float a, b, c;
  float d, e, f;
  float g, h, i;
  GL3R() 
  {
  }
  GL3R(float _a, float _b, float _c, float _d, float _e, float _f, float _g, float _h, float _i) 
  {
    a=_a;
    b=_b;
    c=_c;
    d=_d;
    e=_e;
    f=_f;
    g=_g;
    h=_h;
    i=_i;
  }

  boolean isGL3R() 
  {
    if (a*d-b*c!=0) return true;
    else return false;
  }

  PVector moveByMatrix(PVector v) 
  {
    return new PVector(
    a*v.x+b*v.y+c, d*v.x+e*v.y+f
    );
  }

  Path moveByMatrix(Path p) 
  {
    Path q = new Path();
    for (int j=0; j<p.size(); j++) 
    {
      q.addPVector(moveByMatrix(p.get(j)));
    }
    return q;
  }
}

GL3R prod(GL3R f, GL3R g) 
{
  return new GL3R(
    f.a*g.a+f.b*g.d+f.c*g.g, f.a*g.b+f.b*g.e+f.c*g.h, f.a*g.c+f.b*g.f+f.c*g.i, 
    f.d*g.a+f.e*g.d+f.f*g.g, f.d*g.b+f.e*g.e+f.f*g.h, f.d*g.c+f.e*g.f+f.f*g.i, 
    f.g*g.a+f.h*g.d+f.i*g.g, f.g*g.b+f.h*g.e+f.i*g.h, f.g*g.c+f.h*g.f+f.i*g.i
    );
}