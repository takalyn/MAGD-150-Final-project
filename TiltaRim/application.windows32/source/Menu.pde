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
        click.rate(2);
        click.play();
        if(message=="Quit" && !endGame){
          exit();
          return false;
        }else if(message=="New Game"){
          time = 30;
          score = 0;
          endGame = false;
          return true;
        }else if(message=="Main Menu"){
          delay(300);
          return true;
        }else{return false;}
    }else{return false;}
  }
};
public class Menu{
  PFont title;
  Button quit;
  PImage wallpaper;
  Menu(){
    quit = new Button(640, 585, 426, 90, "Quit");
    title = createFont("stencil.ttf",72);
    wallpaper = loadImage("mainmenu.jpg");
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
public class EndGame{
  Button mainMenu;
  PFont title, scoref;
  PrintWriter output;
  BufferedReader input;
  String highScore;
  String[] lines;
  int sound;
  EndGame(){
    mainMenu = new Button(640, 585, 426, 90, "Main Menu");
    title = createFont("stencil.ttf",72);
    scoref = createFont("ocra.ttf", 56);
    lines = loadStrings("data/topScores.txt");
    sound = 1;
  }
  void display(int score){
    pushStyle();
      fill(255,128);
      rect(640,360,1280,720);
      popStyle();
    fill(192,32,32);
    textFont(title);
    text("GAME OVER", 640, 108);
    fill(0);
    textFont(scoref);
    text("Score: " + score, 640, 256);
    if(score <= Integer.parseInt(lines[0])){
      if(sound==1){
        buzzer.play();
        sound--;
      }
      textFont(scoref);
      text("High Score: " + Integer.parseInt(lines[0]), 640, 320);
    }else{
      if(sound==1){
        cheering.play();
        sound--;
      }
      textFont(scoref);
      text("New High Score!", 640, 320);
    }
    mainMenu.display();
    if(mainMenu.input()){
      sound++;
      gameRunning = false;
      lines[0] = Integer.toString(score);
      saveStrings("data/topScores.txt",lines);
      time = 30;
      score = 0;
      ball.sx = ball.sy = ball.smx = ball.smy = -100;
    }
  }
};
