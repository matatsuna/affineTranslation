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

int mode = 2;

ArrayList<Button> stageButtons;

void setup() {
  size(1200, 800);
  buttons = setButtons();
  stageButtons = stageButton();

  matrixs = new ArrayList<GL3R>();

  myp=new Plane();
  originalFigure = new ArrayList<Path>();
  translatedFigure = new ArrayList<Path>();
  mouse = false;

  setFMS();
}


void draw() {
  if (mode == 1) {
    top();
  } else if (mode == 2) {
    selectStage();
  } else if (mode == 3) {
    game();
  } else if (mode == 4) {
    score();
  }
}

void top() {
  background(0);
  textAlign(CENTER);
  textSize(50);
  stroke(200);
  text("affineTranslation!", width/2, height/2);
  Button _button = new Button((width-400)/2, height/3*2, 400, 100, "SELECT STAGE", 50);
  _button.draw();

  if (mousePressed) {
    if (log) {
      println("mouse ok");
    }
    if (_button.isInside()) {
      if (log) {
        println("inside ok");
      }
      mode = 2;
    }
  }
}

void selectStage() {
  background(0);
  textAlign(CENTER);
  textSize(50);
  stroke(200);
  text("SELECT STAGE", width/2, height/8);
  Button _startButton = new Button((width-200)/2, height/5*4, 200, 100, "START", 50);


  for (Button _stageButton : stageButtons) {
    if (_stageButton.isInside()) {
      _stageButton.setColor(200, 100, 100);
    } else {
      _stageButton.setColor(0, 0, 0);
    }
    if (_stageButton.selected) {
      _stageButton.setColor(255, 0, 0);
    }
    _stageButton.draw();
  }

  if (_startButton.isInside()) {
    _startButton.setColor(100, 100, 100);
  }

  if (mousePressed) {
    if (_startButton.isInside()) {
      for (Button _stageButton : stageButtons) {
        if (_stageButton.selected) {
          loadMap(_stageButton.content);
          mode = 3;
        }
      }
    }
    for (Button _stageButton : stageButtons) {
      _stageButton.selected = false;
    }
    for (Button _stageButton : stageButtons) {
      if (_stageButton.isInside()) {
        _stageButton.selected = true;
      }
    }
  }
  _startButton.draw();
}
void loadMap(String _str) {
  if (_str.equals("1")) {
    myTranslate(2.0, 0);
  }
}
ArrayList<Button> stageButton() {
  ArrayList<Button> _stageButtons = new ArrayList();

  Button _button;

  int _x = 250;
  int _y = 200;
  int _w = 100;
  int _h = 100;

  /*1行目*/
  _button = new Button(_x, _y, _w, _h, "1", 30);
  _stageButtons.add(_button);

  _button = new Button(_x+(_w+50), _y, _w, _h, "2", 30);
  _stageButtons.add(_button);

  _button = new Button(_x+(_w+50)*2, _y, _w, _h, "3", 30);
  _stageButtons.add(_button);

  _button = new Button(_x+(_w+50)*3, _y, _w, _h, "4", 30);
  _stageButtons.add(_button);

  _button = new Button(_x+(_w+50)*4, _y, _w, _h, "5", 30);
  _stageButtons.add(_button);


  /*2行目*/
  _button = new Button(_x, _y+(_h+50)*1, _w, _h, "6", 30);
  _stageButtons.add(_button);

  _button = new Button(_x+(_w+50), _y+(_h+50)*1, _w, _h, "7", 30);
  _stageButtons.add(_button);

  _button = new Button(_x+(_w+50)*2, _y+(_h+50)*1, _w, _h, "8", 30);
  _stageButtons.add(_button);

  _button = new Button(_x+(_w+50)*3, _y+(_h+50)*1, _w, _h, "9", 30);
  _stageButtons.add(_button);

  _button = new Button(_x+(_w+50)*4, _y+(_h+50)*1, _w, _h, "10", 30);
  _stageButtons.add(_button);

  /*?*/
  _button = new Button(_x+(_w+50)*2, _y+(_h+50)*2, _w, _h, "?", 30);
  _stageButtons.add(_button);


  return _stageButtons;
}

void score() {
  background(0);
}

void game() {

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
  if (distPath < 1.0) {
    mode = 4;
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