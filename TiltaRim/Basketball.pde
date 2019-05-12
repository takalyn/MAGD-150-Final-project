public class Basketball{
  PImage basketball;
  int x, y, xv, yv, sx, sy, smx, smy;
  int a = 928;//pixels per sec per sec accel based on frame height of 7.6M
  Basketball(){
    basketball = loadImage("basketball.png");
    basketball.resize(72,72);
    x=36;
    y=360;
    xv = yv = 0;
  }
  void display(boolean shot){
    x+=xv;
    y+=yv;
    pushStyle();
    tint(255,128);
    image(basketball, sx, sy);
    stroke(128.0);
    strokeWeight(10);
    line(sx, sy, smx, smy);
    image(basketball, x, y);
    popStyle();
    if(shot)
      yv+=(a/60)/7;
  }
  void onMouse(){
    x = min(mouseX,320);
    y = max(mouseY,360); 
  }
  void shoot(){
     yv=(int)((y-mouseY)/5.5);
     xv=(int)((x-mouseX)/5.5);
  }
  void unShoot(){
    xv=yv=0; 
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
