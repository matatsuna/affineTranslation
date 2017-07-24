ArrayList<Path> originalFigure ;
Path originalPath;
ArrayList<Path> translatedFigure ;

GL2R matrix1=new GL2R(
  1, -2, 1, 1
  );

GL2R matrix2=new GL2R(
  1, 2, 1, -1
  );

Plane myp;

void setup() {
  size(800, 800);
  myp=new Plane();
  originalFigure = new ArrayList<Path>();
  translatedFigure = new ArrayList<Path>();

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

  GL2R matrix = prod(matrix2, matrix1);

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