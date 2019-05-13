import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class TiltaRim extends PApplet {


SoundFile button, buzzer, cheering, click, swoosh, tada;
Menu main;
EndGame end;
Basketball ball;
Button newGame;
Hoop hoop;
boolean gameRunning, endGame, shot;
int score,time;
PFont fontScore;
PImage background;
public void setup(){
  
  frameRate(60);
  rectMode(CENTER);textAlign(CENTER,CENTER);imageMode(CENTER); //alignment
  buzzer = new SoundFile(this, "buzzer.wav");
  cheering = new SoundFile(this, "cheering.wav");
  click = new SoundFile(this, "click.wav");
  swoosh = new SoundFile(this, "swoosh.wav");
  tada = new SoundFile(this, "tada.wav");
  background = loadImage("brickwall.jpg");
  main = new Menu();
  newGame = new Button(640, 405, 426, 90, "New Game");
  gameRunning = shot = false;
  ball = new Basketball();
  hoop = new Hoop();
  end = new EndGame();
  score = 0;
  fontScore = createFont("ocra.ttf", 36);
  time=30;
}
public void draw(){
  if(!gameRunning){
      main.display();
      gameRunning = newGame.input();
      endGame = false;
  }else if(gameRunning){
      image(background, 640, 360);
      pushStyle();
        textAlign(LEFT, TOP);
        fill(255);
        textFont(fontScore);
        text("Score: " + score, 0,0);
        popStyle();
      pushStyle();
        textAlign(RIGHT, TOP);
        fill(255);
        textFont(fontScore);
        if(time<10)
          fill(255,0,0);
        text("Time: " + time, 1280,0);
        popStyle();
      if(!mousePressed && !shot && !endGame)
        ball.onMouse();
      hoop.display();
      ball.display(shot);
      if(mousePressed && !shot && !endGame){
        ball.drawLine();
      }
      if(ball.x > 1200 && ball.x < 1280 && ball.y> hoop.y-48 && ball.y < hoop.y+48 && ball.yv > 0 && ball.yv/ball.xv > .1f){
        tada.play();
        score++;
        hoop.newPos();
        ball.unShoot();
      }else if(ball.x>1280 || ball.y > 720){
        swoosh.play();
        ball.unShoot();
      }
      if(frameCount%60==0 && !endGame)
        time-=1;
      if(time<1)
        endGame=true;
      if(endGame){
        end.display(score);
    }
  }
}
public void mousePressed(){
  if(shot && !endGame){
      ball.unShoot();
      ball.onMouse();
      shot = false;
    }
}
public void mouseReleased(){
  if(!endGame){
   if(!shot && time<30){
     ball.shadow();
     ball.shoot();
   }else if(shot)
     ball.unShoot();
  }
}
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
  public void display(boolean shot){
    x+=xv;
    y+=yv;
    pushStyle();
      tint(255,192);
      image(basketball, sx, sy);
      stroke(0xff808080);
      strokeWeight(10);
      line(sx, sy, smx, smy);
      popStyle();
    image(basketball, x, y);
    if(shot)
      yv+=(a/60)/7;
  }
  public void onMouse(){
    x = min(mouseX,320);
    y = max(mouseY,360); 
  }
  public void shoot(){
    shot = true;
     yv=(int)((y-mouseY)/5);
     xv=(int)((x-mouseX)/5);
  }
  public void unShoot(){
    xv=yv=0;
    x=mouseX;
    y=mouseY;
    shot = false;
  }
  public void drawLine(){
    pushStyle();
    strokeWeight(10);
    line(mouseX,mouseY,x,y);
    popStyle();
  }
  public void shadow(){
    sx = x;
    sy = y;
    smx = mouseX;
    smy = mouseY;
  }
};
public class Hoop{
  PImage hoop;
  int x,y;
  Hoop(){
    hoop = loadImage("hoop4.png");
    hoop.resize(96,96);
    x=1232;
    y=384;
  }
  public void display(){
    image(hoop,x,y);
  }
  public void newPos(){
    y=(int)random(312)+228;
  }
};
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
  public void display(){
    pushStyle();
    fill(128);
    stroke(64);
    rect(x,y,w,h);
    fill(255);
    textFont(button);
    text(message, x, y);
    popStyle();
  }
  public boolean input(){
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
  public void display(){
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
  public void display(int score){
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
  public void settings() {  size(1280,720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TiltaRim" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
