public class Hoop{
  PImage hoop;
  int x,y;
  Hoop(){
    hoop = loadImage("hoop4.png");
    hoop.resize(96,96);
    x=1232;
    y=384;
  }
  void display(){
    image(hoop,x,y);
  }
  void newPos(){
    y=(int)random(312)+228;
  }
};
