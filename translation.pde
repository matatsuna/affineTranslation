
void myRotate(float _pi) {
  GL3R gl3r = new GL3R(
    cos(_pi), -sin(_pi), 0, 
    sin(_pi), cos(_pi), 0, 
    0, 0, 1
    );
  matrixs.add(gl3r);
}
void myScale(float _rate) {
  GL3R gl3r = new GL3R(
    _rate, 0, 0, 
    0, _rate, 0, 
    0, 0, 1
    );
  matrixs.add(gl3r);
}