public class Basketball{
  PImage basketball;
  int x, y, xv, yv, sx, sy, smx, smy;
  int a = 928;//pixels per sec per sec accel based on frame height of 7.6M
  Basketball(){
    basketball = loadImage("basketball.png");
    basketball.resize(64,64);
    x=36;
    y=360;
    xv = yv = 0;
    sx= sy = -100;
  }
  void display(boolean shot){
    x+=xv;
    y+=yv;
    pushStyle();
      tint(255,192);
      image(basketball, sx, sy);
      stroke(#808080);
      strokeWeight(10);
      line(sx, sy, smx, smy);
      popStyle();
    image(basketball, x, y);
    if(shot)
      yv+=(a/60)/7;
  }
  void onMouse(){
    x = min(mouseX,320);
    y = max(mouseY,360); 
  }
  void shoot(){
    shot = true;
     yv=(int)((y-mouseY)/5);
     xv=(int)((x-mouseX)/5);
  }
  void unShoot(){
    xv=yv=0;
    x=mouseX;
    y=mouseY;
    shot = false;
  }
  void drawLine(){
    pushStyle();
    strokeWeight(10);
    line(mouseX,mouseY,x,y);
    popStyle();
  }
  void shadow(){
    sx = x;
    sy = y;
    smx = mouseX;
    smy = mouseY;
  }
};
