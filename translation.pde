
void myRotate(float _pi) {
  GL2R gl2r = new GL2R(cos(_pi), -sin(_pi), sin(_pi), cos(_pi));
  matrixs.add(gl2r);
}
void myScale(float _rate) {
  GL2R gl2r = new GL2R(_rate, 0, 0, _rate);
  matrixs.add(gl2r);
}