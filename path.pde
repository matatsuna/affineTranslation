class Path 
{
  //PVectorの集まり
  //描画する座標の点を管理する
  ArrayList<PVector> p;
  Path() 
  {
    p = new ArrayList<PVector>();
  }
  
  void addPVector(PVector v) 
  {
    p.add(v);
  }
  
  void drawPath() 
  {
    for (int j=0; j<p.size ()-1; j++) 
    {
      line(myp.X(p.get(j).x), myp.Y(p.get(j).y), myp.X(p.get(j+1).x), myp.Y(p.get(j+1).y));
    }
  }

  int size() 
  {
    return p.size();
  }
  
  PVector get(int i) 
  {
    return p.get(i);
  }
  
  float compareDist(Path _path) 
  {
    ArrayList<PVector> _pvector = _path.p;
    if (p.size()!=_pvector.size()) 
    {
      return -1;
    }
    float sum =0;
    for (int i=0; i<_pvector.size(); i++) 
    {
      PVector mypvector = p.get(i);
      PVector _inpvector = _pvector.get(i);
      sum += dist(mypvector.x, mypvector.y, _inpvector.x, _inpvector.y);
    }
    if (log) 
    {
      println("距離の計算", sum);
    }
    return sum;
  }
}