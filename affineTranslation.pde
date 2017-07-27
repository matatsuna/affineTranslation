/*

 affineTranslation.pde
 */
 
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

int mode = 1;

ArrayList<Button> stageButtons;

int startTime;

boolean scoreFlag = true;
int scoreTime = 0;

int[] scoreData; 
File file;

String stage;
void setup()
{
  size(1200, 800);
  buttons = setButtons();
  stageButtons = stageButton();

  matrixs = new ArrayList<GL3R>();

  myp=new Plane();

  mouse = false;

  scoreData = new int [10];
  file = new File(sketchPath("scoreData.json"));
  if (file.exists()) 
  {
    scoreData = loadScore(file);
  }

  stage = "0";
}


void draw() 
{
  if (mode == 1)
  {
    top();
  } else if (mode == 2) 
  {
    selectStage();
  } else if (mode == 3) 
  {
    game();
  } else if (mode == 4) 
  {
    score();
  } else if (mode==5) 
  {
    help();
  }
}

void top() 
{
  background(0);
  textAlign(CENTER);
  textSize(100);
  stroke(200);
  text("affineTranslation!", width/2, height/4);
  Button _button = new Button(
    (width-400)/2, height/3*2, 400, 100, "SELECT STAGE", 50
    );

  Button _helpButton = new Button(
    (width-200), height-100, 50, 50, "?", 30
    );
  _helpButton.isCircle = true;

  if (_button.isInside()) 
  {
    _button.setColor(100, 100, 100);
  }

  if (_helpButton.isInside())
  {
    _helpButton.setColor(100, 100, 100);
  }

  if (mousePressed)
  {
    if (log) 
    {
      println("mouse ok");
    }
    if (_button.isInside()) 
    {
      if (log) 
      {
        println("inside ok");
      }
      mode = 2;
    }
    if (_helpButton.isInside())
    {
      mode = 5;
    }
  }
  _button.draw();
  _helpButton.draw();
}

void help()
{
  background(0);
  textAlign(CENTER);
  textSize(50);
  stroke(200);
  text("Developer:@matatsuna", width/2, height/2);
  Button _button = new Button(
    (width-400)/2, height/5*4, 400, 100, "BACK", 50
    );
  if (_button.isInside())
  {
    _button.setColor(100, 100, 100);
    if (mousePressed)
    {
      mode = 1;
    }
  }
  _button.draw();
}


void selectStage()
{
  background(0);
  textAlign(CENTER);
  textSize(50);
  stroke(200);
  text("SELECT STAGE", width/2, height/8);
  Button _startButton = new Button(
    (width-200)/2, height/5*4, 200, 100, "START", 50
    );
  Button _backButton = new Button(
    10, height/5*4, 200, 100, "BACK", 50
    );
  Button _exitButton = new Button(
    width-210, height/5*4, 200, 100, "EXIT", 50
    );

  for (Button _stageButton : stageButtons) 
  {
    if (_stageButton.isInside()) 
    {
      _stageButton.setColor(200, 100, 100);
    } else 
    {
      _stageButton.setColor(0, 0, 0);
    }
    if (_stageButton.selected)
    {
      _stageButton.setColor(255, 0, 0);
    }
    _stageButton.draw();
  }
  for (Button _stageButton : stageButtons) 
  {
    if (_stageButton.isInside()) 
    {
      if (!_stageButton.content.equals("?")) 
      {
        if (scoreData[int(_stageButton.content)-1]!=0) 
        {
          textSize(30);
          text("Score:"+str(scoreData[int(_stageButton.content)-1]), mouseX+80, mouseY+40);
        }
      }
    }
  }

  if (_startButton.isInside()) 
  {
    _startButton.setColor(100, 100, 100);
  }

  if (_backButton.isInside()) 
  {
    _backButton.setColor(100, 100, 200);
  }

  if (_exitButton.isInside()) 
  {
    _exitButton.setColor(100, 200, 100);
  }

  if (mousePressed) 
  {
    if (_startButton.isInside()) 
    {
      for (Button _stageButton : stageButtons)
      {
        if (_stageButton.selected)
        {
          if (log)
          {
            println("gameの初期化");
          }
          //ターゲットの文字を設定する
          setFMS();
          loadMap(_stageButton.content);
          stage = _stageButton.content;
          startTime = nowTime();
          scoreFlag =true;
          mode = 3;
          _stageButton.selected = false;
        }
      }
    }
    if (_backButton.isInside())
    {
      mode = 1;
    }
    if (_exitButton.isInside())
    {
      if (saveScore(scoreData))
      {
        println("保存しました。");
        exit();
      } else
      {
        println("保存に失敗しました。");
      }
    }
    for (Button _stageButton : stageButtons)
    {
      _stageButton.selected = false;
    }
    for (Button _stageButton : stageButtons) 
    {
      if (_stageButton.isInside()) 
      {
        _stageButton.selected = true;
      }
    }
  }
  _startButton.draw();
  _backButton.draw();
  _exitButton.draw();
}
void loadMap(String _str) 
{
  if (_str.equals("1")) 
  {
    myTranslate(2.0, 0);
  }
  if (_str.equals("2")) 
  {
    myTranslate(2.0, 0);
    myTranslate(0.0, 3.0);
  }
  if (_str.equals("3")) 
  {
    myRotate(radians(30));
    myTranslate(2.0, 3.0);
  }
  if (_str.equals("4")) 
  {
    myRotate(radians(20));
    myTranslate(4.0, 1.0);
    myRotate(radians(30));
  }
  if (_str.equals("5")) 
  {
    myTranslate(1.0, -3.0);
    myRotate(radians(10));
    myTranslate(2.0, 1.0);
    myRotate(radians(60));
  }
  if (_str.equals("6")) 
  {
    myScale(2.0);
    myTranslate(1.0, 3.0);
    myRotate(radians(10));
    myTranslate(2.0, -1.0);
    myRotate(-radians(60));
    myTranslate(-5.0, -6.0);
    myScale(0.3);
  }
  if (_str.equals("7")) 
  {
    //青色の座標変換
    GL3R _matrix;
    _matrix = new GL3R(
      1, 0, -3, 
      0, 1, 4, 
      0, 0, 1
      );

    ArrayList<Path> newFigure =  new ArrayList<Path>();
    for (Path path : originalFigure) 
    {
      newFigure.add( _matrix.moveByMatrix(path));
    }
    originalFigure = newFigure;

    //赤色の座標変換
    myScale(2.0);
    myTranslate(1.0, 3.0);
    myRotate(radians(40));
    myTranslate(-2.0, -1.0);
    myRotate(-radians(60));
    myTranslate(-3.0, -4.0);
    myScale(0.5);
  }
  if (_str.equals("8")) 
  {
    //青色の座標変換
    GL3R _matrix;
    _matrix = new GL3R(
      1.6, 0, -4, 
      0, 1.6, -5, 
      0, 0, 1
      );

    ArrayList<Path> newFigure =  new ArrayList<Path>();
    for (Path path : originalFigure) 
    {
      newFigure.add( _matrix.moveByMatrix(path));
    }
    originalFigure = newFigure;

    //赤色の座標変換
    myScale(2.0);
    myRotate(-radians(40));
    myTranslate(2.0, 1.0);
  }
  if (_str.equals("9")) 
  {
    //青色の座標変換
    GL3R _matrix;
    float theta = radians(105);
    _matrix = new GL3R(
      cos(theta), -sin(theta), -5, 
      sin(theta), cos(theta), -2, 
      0, 0, 1
      );

    ArrayList<Path> newFigure =  new ArrayList<Path>();
    for (Path path : originalFigure) 
    {
      newFigure.add( _matrix.moveByMatrix(path));
    }
    originalFigure = newFigure;

    //赤色の座標変換
    myScale(0.6);
    myTranslate(5.0, 2.0);
    myRotate(-radians(105));
    myTranslate(5.0, 2.0);
  }
  if (_str.equals("10")) 
  {
    //青色の座標変換
    GL3R _matrix;
    float theta = radians(75);
    GL3R _matrix1 = new GL3R(
      cos(theta), -sin(theta), 3, 
      sin(theta), cos(theta), -1, 
      0, 0, 1
      );
    theta = radians(-125);
    GL3R _matrix2 = new GL3R(
      cos(theta), -sin(theta), 0, 
      sin(theta), cos(theta), 0, 
      0, 0, 1
      );
    _matrix = prod(_matrix1, _matrix2);
    ArrayList<Path> newFigure =  new ArrayList<Path>();
    for (Path path : originalFigure) 
    {
      newFigure.add( _matrix.moveByMatrix(path));
    }
    originalFigure = newFigure;

    //赤色の座標変換
    myScale(0.2);
    myTranslate(5.0, 2.0);
    myRotate(radians(105));
    myTranslate(10.0, 8.0);
  }
  if (_str.equals("?")) 
  {
    for (int i=0; i<(int)random(1, 5); i++) 
    {
      switch((int)random(3)) 
      {
      case 0:
        myTranslate(random(5), random(5));
      case 1:
        myScale(random(5));
      case 2:
        myRotate(random(5));
      }
    }
  }
}
ArrayList<Button> stageButton()
{
  ArrayList<Button> _stageButtons = new ArrayList();

  Button _button;

  int _x = 250;
  int _y = 200;
  int _w = 100;
  int _h = 100;

  /*1行目*/
  _button = new Button(
    _x, _y, _w, _h, "1", 30
    );
  _stageButtons.add(_button);

  _button = new Button(
    _x+(_w+50), _y, _w, _h, "2", 30
    );
  _stageButtons.add(_button);

  _button = new Button(
    _x+(_w+50)*2, _y, _w, _h, "3", 30
    );
  _stageButtons.add(_button);

  _button = new Button(
    _x+(_w+50)*3, _y, _w, _h, "4", 30
    );
  _stageButtons.add(_button);

  _button = new Button(
    _x+(_w+50)*4, _y, _w, _h, "5", 30
    );
  _stageButtons.add(_button);


  /*2行目*/
  _button = new Button(
    _x, _y+(_h+50)*1, _w, _h, "6", 30
    );
  _stageButtons.add(_button);

  _button = new Button(
    _x+(_w+50), _y+(_h+50)*1, _w, _h, "7", 30
    );
  _stageButtons.add(_button);

  _button = new Button(
    _x+(_w+50)*2, _y+(_h+50)*1, _w, _h, "8", 30
    );
  _stageButtons.add(_button);

  _button = new Button(
    _x+(_w+50)*3, _y+(_h+50)*1, _w, _h, "9", 30
    );
  _stageButtons.add(_button);

  _button = new Button(
    _x+(_w+50)*4, _y+(_h+50)*1, _w, _h, "10", 30
    );
  _stageButtons.add(_button);

  /*?*/
  _button = new Button(
    _x+(_w+50)*2, _y+(_h+50)*2, _w, _h, "?", 30
    );
  _stageButtons.add(_button);

  return _stageButtons;
}

void score() 
{
  if (scoreFlag)
  {
    scoreFlag = false;
    scoreTime = nowTime() - startTime;
    if (!stage.equals("?"))
    {
      if (scoreData[int(stage)-1] == 0)
      {
        scoreData[int(stage)-1] = scoreTime;
      } else
      {
        scoreData[int(stage)-1] = min(scoreData[int(stage)-1], scoreTime);
      }
    }
  }
  background(0);
  textAlign(CENTER);
  textSize(50);
  stroke(200);
  text("STAGE CLEAR", width/2, height/4);
  text("SCORE:Time", width/2, height/3);
  text(scoreTime+" sec", width/2, height/2);
  Button nextButton = new Button(
    (width-200)/2, height/5*4, 200, 100, "NEXT", 50
    );
  if (nextButton.isInside()) 
  {
    nextButton.setColor(100, 100, 100);
  }
  if (mousePressed) 
  {
    if (nextButton.isInside()) 
    {
      stageButtons = stageButton();
      mode = 2;
    }
  }
  nextButton.draw();
}

void game()
{

  //行列の計算
  GL3R matrix = new GL3R();

  if (matrixs.size() == 0) 
  {
    matrix = new GL3R(
      1, 0, 0, 
      0, 1, 0, 
      0, 0, 1
      );
  } else if (matrixs.size() == 1) 
  {
    matrix = matrixs.get(0);
  } else if (matrixs.size()>1)
  {
    for (int i=0; i<matrixs.size()-1; i++) 
    {
      if (i==0) 
      {
        matrix = prod(matrixs.get(0), matrixs.get(1));
      } else 
      {
        matrix = prod(matrix, matrixs.get(i+1));
      }
    }
  }

  background(0);
  myp.drawAxis();


  for (Button _button : buttons) 
  {
    _button.draw();
  }

  if (!preMousePressed && mousePressed) 
  {
    preMousePressed = true;
    for (Button _button : buttons) 
    {
      if (_button.isInside()) 
      {
        if (_button.content .equals("↑")) 
        {
          if (log) 
          {
            println(_button.content);
          }
          myTranslate(0, 0.05);
        } else if (_button.content.equals("↓")) 
        {
          if (log)
          {
            println(_button.content);
          }
          myTranslate(0, -0.05);
        } else if    (_button.content.equals("←")) 
        {
          if (log)
          {
            println(_button.content);
          }
          myTranslate(-0.05, 0);
        } else if (_button.content.equals("→")) 
        {
          if (log) 
          {
            println(_button.content);
          }
          myTranslate(0.05, 0);
        } else if (_button.content.equals("Left"))
        {
          if (log) 
          {
            println(_button.content);
          }
          myRotate(radians(3));
        } else if (_button.content.equals("Right"))
        {
          if (log) 
          {
            println(_button.content);
          }
          myRotate(-radians(3));
        } else if (_button.content.equals("-"))
        {
          if (log) 
          {
            println(_button.content);
          }
          myScale(98.0/100.0);
        } else if (_button.content.equals("+")) 
        {
          if (log)
          {
            println(_button.content);
          }
          myScale(102.0/100.0);
        } else if (_button.content.equals("BACK"))
        {
          if (log)
          {
            println(_button.content);
          }
          stageButtons = stageButton();
          mode = 2;
        }
      }
    }
  } else 
  {
    preMousePressed = false;
  }

  stroke(200, 200, 255);
  strokeWeight(3);

  // draw 'FMS'
  for (Path path : originalFigure) 
  {
    path.drawPath();
  }

  // move letters by a matrix
  //座標にかける
  translatedFigure = new ArrayList<Path>();
  ArrayList<Path> originFigure = new ArrayList<Path>();
  originFigure = setFMSArray();
  for (Path path : originFigure)
  {
    translatedFigure.add( matrix.moveByMatrix(path));
  }

  // draw new letters
  stroke(255, 128, 128);
  strokeWeight(3);
  float distPath= 0;
  for (int i = 0; i<translatedFigure.size(); i++) 
  {
    Path path = translatedFigure.get(i);
    distPath += path.compareDist(originalFigure.get(i));
    path.drawPath();
  }
  if (log) 
  {
    println("すべての文字に対しての距離", distPath);
  }
  if (distPath < 1.0) 
  {
    //終了条件クリア条件
    mode = 4;
  }
}
ArrayList<Button> setButtons()
{
  //各種ボタンの初期設定
  ArrayList<Button> _buttons = new ArrayList<Button>();
  //Button _button;
  int centerX = 1000;
  int centerY = 200;
  int w = 100;
  int h = 50;
  Button _button1 = new Button(
    centerX, centerY-80, w, h, "↑", 50
    );
  _buttons.add(_button1);

  Button _button2 = new Button(
    centerX, centerY+80, w, h, "↓", 50
    );
  _buttons.add(_button2);

  Button _button3 = new Button(
    centerX-50, centerY, w, h, "←", 50
    );
  _buttons.add(_button3);

  Button _button4 = new Button(
    centerX+50, centerY, w, h, "→", 50
    );
  _buttons.add(_button4);

  centerY = 400;

  Button _button5 = new Button(
    centerX-50, centerY, w, h, "Left", 30
    );
  _buttons.add(_button5);

  Button _button6 = new Button(
    centerX+50, centerY, w, h, "Right", 30
    );
  _buttons.add(_button6);

  centerY = 500;

  Button _button7 = new Button(
    centerX-50, centerY, w, h, "-", 50
    );
  _buttons.add(_button7);

  Button _button8 = new Button(
    centerX+50, centerY, w, h, "+", 50
    );
  _buttons.add(_button8);

  centerY = 600;
  Button _button9 = new Button(
    centerX, centerY, w, h, "BACK", 30
    );
  _buttons.add(_button9);

  return _buttons;
}
void setFMS() 
{
  if (log) 
  {
    println("originalFigure/translatedFigureの初期化");
  }
  originalFigure = new ArrayList<Path>();
  translatedFigure = new ArrayList<Path>();
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
ArrayList<Path> setFMSArray()
{
  ArrayList<Path> _originalFigure = new ArrayList<Path>();
  /// FMS!のsetup追加
  Path originalPath;
  originalPath = new Path();
  originalPath.addPVector(new PVector(0, 0));
  originalPath.addPVector(new PVector(0, 1));
  originalPath.addPVector(new PVector(1, 1));
  _originalFigure.add(originalPath);

  originalPath = new Path();
  originalPath.addPVector(new PVector(0, 0.5));
  originalPath.addPVector(new PVector(0.8, 0.5));
  _originalFigure.add(originalPath);

  originalPath = new Path();
  originalPath.addPVector(new PVector(1.1, 0));
  originalPath.addPVector(new PVector(1.1, 1));
  originalPath.addPVector(new PVector(1.6, 0.5));
  originalPath.addPVector(new PVector(2.1, 1));
  originalPath.addPVector(new PVector(2.1, 0));
  _originalFigure.add(originalPath);

  originalPath = new Path();
  originalPath.addPVector(new PVector(3.2, 1));
  originalPath.addPVector(new PVector(2.2, 1));
  originalPath.addPVector(new PVector(2.2, 0.5));
  originalPath.addPVector(new PVector(3.2, 0.5));
  originalPath.addPVector(new PVector(3.2, 0));
  originalPath.addPVector(new PVector(2.2, 0));
  _originalFigure.add(originalPath);
  return _originalFigure;
}

int nowTime() 
{
  //現在の時間を返す
  int day = day();
  int hour = hour();
  int minute = minute();
  int second = second();
  int timestamp = second + minute*60 +hour*60*60 + day*60*60*24;
  return timestamp;
}

boolean saveScore(int [] _scoredata) 
{
  try 
  {
    JSONObject json = new JSONObject();
    json.setInt("1", _scoredata[0]);
    json.setInt("2", _scoredata[1]);
    json.setInt("3", _scoredata[2]);
    json.setInt("4", _scoredata[3]);
    json.setInt("5", _scoredata[4]);
    json.setInt("6", _scoredata[5]);
    json.setInt("7", _scoredata[6]);
    json.setInt("8", _scoredata[7]);
    json.setInt("9", _scoredata[8]);
    json.setInt("10", _scoredata[9]);

    saveJSONObject(json, "scoreData.json");
  }
  catch(Exception e) 
  {
    return false;
  }
  return true;
}
int [] loadScore(File _file)
{
  int [] _scoredata = new int [10];
  try 
  {
    if (_file.exists()) 
    {
      JSONObject json = loadJSONObject(_file.getPath());
      _scoredata[0] = int(json.getInt("1"));
      _scoredata[1] = int(json.getInt("2"));
      _scoredata[2] = int(json.getInt("3"));
      _scoredata[3] = int(json.getInt("4"));
      _scoredata[4] = int(json.getInt("5"));
      _scoredata[5] = int(json.getInt("6"));
      _scoredata[6] = int(json.getInt("7"));
      _scoredata[7] = int(json.getInt("8"));
      _scoredata[8] = int(json.getInt("9"));
      _scoredata[9] = int(json.getInt("10"));
    }
  }
  catch (Exception e) 
  {
    println(e);
  }
  return _scoredata;
}