class path {
  ArrayList<PVector> p;
  path() {
    p = new ArrayList<PVector>();
  }
  void addPVector(PVector v) {
    p.add(v);
  }
  void drawPath() {
    for (int j=0; j<p.size ()-1; j++) {
      line(myp.X(p.get(j).x), myp.Y(p.get(j).y), myp.X(p.get(j+1).x), myp.Y(p.get(j+1).y));
    }
  }
  int size(){
    return p.size();
  }
  PVector get(int i){
    return p.get(i);
  }
}


