public class Button{
  int x, y, w, h;
  int xs,xe,ys,ye;
  PFont button;
  String message;
  Button(int x, int y, int w, int h, String mess){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    xs=x-(w/2);
    xe=x+(w/2);
    ys=y-(h/2);
    ye=y+(h/2);
    message = mess;
    button = createFont("pixelated.ttf", 72);
  }
  void display(){
    pushStyle();
    fill(128);
    stroke(64);
    rect(x,y,w,h);
    fill(255);
    textFont(button);
    text(message, x, y);
    popStyle();
  }
  boolean input(){
    if(mousePressed && mouseX>xs && mouseX<xe && mouseY>ys && mouseY<ye){
        if(message=="Quit"){
          exit();
          return false;
        }else if(message=="New Game"){
          return true;
        }else{return false;}
    }else{return false;}
  }
};
public class Menu{
  PFont title;
  Button quit;
  PImage wallpaper;
  boolean toggle;
  Menu(){
    quit = new Button(640, 585, 426, 90, "Quit");
    title = createFont("stencil.ttf",72);
    wallpaper = loadImage("mainmenu.jpg");
    toggle = false;
  }
  void display(){
    image(wallpaper, 640, 360, 1280, 720);
    newGame.display();
    quit.display();
    quit.input();
    pushStyle();
    fill(192);
    textFont(title);
    text("Tilt-a-Rim", 640, 108);
    popStyle();
  }
};
