class Button {
  int x=0;
  int y=0;
  int w=0;
  int h=0;
  String content;
  int red = 0;
  int green = 0;
  int blue = 0;
  int m_iCommand = 0;
  int fontSize = 0;
  boolean selected = false;

  Button( int _x, int _y, int _w, int _h, String _content, int _fontSize) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    content = _content;
    fontSize =  _fontSize ;
  }

  void setColor( int _r, int _g, int _b ) {
    red = _r;
    green = _g;
    blue = _b;
  }

  void draw() {
    fill(red, green, blue);
    rect( x, y, w, h );
    fill(255);
    textSize(fontSize);
    textAlign(CENTER);
    text( content, x+w/2, y+(h+fontSize)/2 );
  }

  boolean isInside() {
    int _x = mouseX;
    int _y = mouseY;
    if ( _x >= x && _x <= x + w) {
      if ( _y >= y && _y <= y + h ) {
        return true;
      }
    }
    return false;
  }

}