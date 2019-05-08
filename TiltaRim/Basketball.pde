public class Basketball{
  PImage basketball;
  int x, y, xv, yv;
  int a = 928;//pixels per sec per sec accel based on frame height of 7.6M
  Basketball(){
    basketball = loadImage("basketball.png");
    basketball.resize(72,72);
    x=36;
    y=360;
    xv = yv = 0;
  }
  void display(){
    image(basketball, x, y);
    x = mouseX;
    y = mouseY;
  }
};
