class plane {
  int cX, cY;
  int unit;
  plane() {
    cX=400;
    cY=400;
    unit=50;
  }
  int X(float a) {
    return int(cX+a*unit);
  }
  int Y(float a) {
    return int(cY-a*unit);
  }
  void drawAxis() {
    stroke(200);
    strokeWeight(1);
    int a=int(min(cX,cY)/unit);
    line(cX-unit*a, cY, cX+unit*a, cY);
    line(cX, cY-unit*a, cX, cY+unit*a);
  }
}
