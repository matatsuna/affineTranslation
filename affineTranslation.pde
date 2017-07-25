ArrayList<Path> originalFigure ;
Path originalPath;
ArrayList<Path> translatedFigure ;

ArrayList<GL3R> matrixs;

GL3R matrix1=new GL3R(
  1, 2, 0, 
  1, -1, 0, 
  0, 0, 1
  );

GL3R matrix2=new GL3R(
  1, -2, 0, 
  1, 1, 0, 
  0, 0, 1
  );

Plane myp;

void setup() {
  size(800, 800);

  matrixs = new ArrayList<GL3R>();

  myp=new Plane();
  originalFigure = new ArrayList<Path>();
  translatedFigure = new ArrayList<Path>();

  myRotate(radians(-90));
  myRotate(radians(90));
  myScale(2);
  myScale(0.5);

  /// FMS!
  originalPath = new Path();
  originalPath.addPVector(new PVector(0, 0));
  originalPath.addPVector(new PVector(0, 1));
  originalPath.addPVector(new PVector(1, 1));
  originalFigure.add(originalPath);

  originalPath = new Path();
  originalPath.addPVector(new PVector(0, 0.5));
  originalPath.addPVector(new PVector(0.8, 0.5));
  originalFigure.add(originalPath);

  originalPath = new Path();
  originalPath.addPVector(new PVector(1.1, 0));
  originalPath.addPVector(new PVector(1.1, 1));
  originalPath.addPVector(new PVector(1.6, 0.5));
  originalPath.addPVector(new PVector(2.1, 1));
  originalPath.addPVector(new PVector(2.1, 0));
  originalFigure.add(originalPath);

  originalPath = new Path();
  originalPath.addPVector(new PVector(3.2, 1));
  originalPath.addPVector(new PVector(2.2, 1));
  originalPath.addPVector(new PVector(2.2, 0.5));
  originalPath.addPVector(new PVector(3.2, 0.5));
  originalPath.addPVector(new PVector(3.2, 0));
  originalPath.addPVector(new PVector(2.2, 0));
  originalFigure.add(originalPath);
}

void draw() {

  //行列の計算
  GL3R matrix = new GL3R();

  if (matrixs.size() == 0) {
    matrix = new GL3R(
      1, 0, 0, 
      0, 1, 0, 
      0, 0, 1
      );
  } else if (matrixs.size() == 1) {

    matrix = matrixs.get(0);
  } else if (matrixs.size()>1) {
    for (int i=0; i<matrixs.size()-1; i++) {
      if (i==0) {
        matrix = prod(matrixs.get(0), matrixs.get(1));
      } else {
        matrix = prod(matrix, matrixs.get(i+1));
      }
    }
  }

  //matrix = prod(matrix1, matrix2);

  background(0);
  myp.drawAxis();
  stroke(200, 200, 255);
  strokeWeight(3);

  // draw 'FMS'
  for (Path path : originalFigure) {
    path.drawPath();
  }

  // move letters by a matrix
  //座標にかける
  for (Path path : originalFigure) {
    translatedFigure.add( matrix.moveByMatrix(path));
  }

  // draw new letters
  stroke(255, 128, 128);
  strokeWeight(3);
  for (Path path : translatedFigure) {
    path.drawPath();
  }
}