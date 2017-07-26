ArrayList<Path> originalFigure ;
Path originalPath;
ArrayList<Path> translatedFigure ;

ArrayList<GL3R> matrixs;

ArrayList<Button>buttons;

Plane myp;

boolean mouse;

PVector mouseClick;
boolean preMousePressed ;

boolean log = true;

void setup() {
  size(1200, 800);
  buttons = setButtons();  

  matrixs = new ArrayList<GL3R>();

  myp=new Plane();
  originalFigure = new ArrayList<Path>();
  translatedFigure = new ArrayList<Path>();
  mouse = false;

  setFMS();
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

  background(0);
  myp.drawAxis();


  for (Button _button : buttons) {
    _button.draw();
  }

  if (!preMousePressed && mousePressed) {
    preMousePressed = true;
    for (Button _button : buttons) {

      if (_button.isInside()) {

        if (_button.content .equals("↑")) {
          if (log) {
            println(_button.content);
          }
          myTranslate(0, 0.05);
        } else if (_button.content.equals("↓")) {
          if (log) {
            println(_button.content);
          }
          myTranslate(0, -0.05);
        } else if (_button.content.equals("←")) {
          if (log) {
            println(_button.content);
          }
          myTranslate(-0.05, 0);
        } else if (_button.content.equals("→")) {
          if (log) {
            println(_button.content);
          }
          myTranslate(0.05, 0);
        } else if (_button.content.equals("Left")) {
          if (log) {
            println(_button.content);
          }
          myRotate(radians(3));
        } else if (_button.content.equals("Right")) {
          if (log) {
            println(_button.content);
          }
          myRotate(-radians(3));
        } else if (_button.content.equals("-")) {
          if (log) {
            println(_button.content);
          }
          myScale(98.0/100.0);
        } else if (_button.content.equals("+")) {
          if (log) {
            println(_button.content);
          }
          myScale(102.0/100.0);
        }
      }
    }
  } else {
    preMousePressed = false;
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
  float distPath= 0;
  for (int i = 0; i<translatedFigure.size(); i++) {
    Path path = translatedFigure.get(i);
    distPath += path.compareDist(originalFigure.get(i));
    path.drawPath();
  }
  if (log) {
    println("すべての文字に対しての距離", distPath);
  }
}
ArrayList<Button> setButtons() {
  //各種ボタンの初期設定
  ArrayList<Button> _buttons = new ArrayList<Button>();
  //Button _button;
  int centerX = 1000;
  int centerY = 200;
  int w = 100;
  int h = 50;
  Button _button1 = new Button(centerX, centerY-80, w, h, "↑", 50);
  _buttons.add(_button1);

  Button _button2 = new Button(centerX, centerY+80, w, h, "↓", 50);
  _buttons.add(_button2);

  Button _button3 = new Button(centerX-50, centerY, w, h, "←", 50);
  _buttons.add(_button3);

  Button _button4 = new Button(centerX+50, centerY, w, h, "→", 50);
  _buttons.add(_button4);

  centerY = 400;

  Button _button5 = new Button(centerX-50, centerY, w, h, "Left", 30);
  _buttons.add(_button5);

  Button _button6 = new Button(centerX+50, centerY, w, h, "Right", 30);
  _buttons.add(_button6);

  centerY = 500;

  Button _button7 = new Button(centerX-50, centerY, w, h, "-", 50);
  _buttons.add(_button7);

  Button _button8 = new Button(centerX+50, centerY, w, h, "+", 50);
  _buttons.add(_button8);


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