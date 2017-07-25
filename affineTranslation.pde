ArrayList<Path> originalFigure ;
Path originalPath;
ArrayList<Path> translatedFigure ;

ArrayList<GL3R> matrixs;

ArrayList<Button>buttons;

Plane myp;

boolean mouse;

PVector mouseClick;
boolean preMousePressed ;

void setup() {
  size(1200, 800);
  buttons = setButtons();  

  matrixs = new ArrayList<GL3R>();

  myp=new Plane();
  originalFigure = new ArrayList<Path>();
  translatedFigure = new ArrayList<Path>();
  mouse = false;

  //myRotate(radians(-90));
  //myRotate(radians(90));
  //myScale(2);
  //myScale(0.5);
  //myTranslate(1, 1);
  //myTranslate(-1, -1);

  setFMS();
}

//void mousePressed() {
//  mouse = true;
//  mouseClick = new PVector(mouseX, mouseY);
//  println("mousePrewwd");
//}

//void mouseReleased() {
//  mouse = false;
//  myTranslate(mouseClick.x-mouseX, mouseClick.y-mouseY);
//  println("mousereleaed");
//}

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

  background(0);
  myp.drawAxis();

  for (Button _button : buttons) {
    _button.draw();
    if (!preMousePressed && mousePressed) {
      preMousePressed = true;
      if (_button.isInside()) {

        if (_button.content .equals("↑")) {
          myTranslate(0, 0.05);
          //GL3R tmpgl3r = new GL3R(
          //  1, 0, 0, 
          //  0, 1, 1.0, 
          //  0, 0, 1
          //  );
          //matrix = prod(matrix, tmpgl3r);
        } else if (_button.content.equals("↓")) {
          myTranslate(0, -0.05);
          //GL3R tmpgl3r = new GL3R(
          //  1, 0, 0, 
          //  0, 1, -1.0, 
          //  0, 0, 1
          //  );
          //matrix = prod(matrix, tmpgl3r);
        }
        
      }
    } else {
      preMousePressed = false;
    }
  }

  stroke(200, 200, 255);
  strokeWeight(3);

  // draw 'FMS'
  for (Path path : originalFigure) {
    path.drawPath();
  }

  // move letters by a matrix
  //座標にかける
  translatedFigure = new ArrayList<Path>();
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
ArrayList<Button> setButtons() {
  //各種ボタンの初期設定
  ArrayList<Button> _buttons = new ArrayList<Button>();
  Button _button;
  _button = new Button(900, 100, 100, 50, "↑", 50);
  _buttons.add(_button);
  _button = new Button(900, 300, 100, 50, "↓", 50);
  _buttons.add(_button);

  return _buttons;
}
void setFMS() {
  /// FMS!のsetup追加
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