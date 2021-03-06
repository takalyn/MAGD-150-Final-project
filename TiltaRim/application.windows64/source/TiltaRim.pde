import processing.sound.*;
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
void setup(){
  size(1280,720);
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
void draw(){
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
      if(ball.x > 1200 && ball.x < 1280 && ball.y> hoop.y-48 && ball.y < hoop.y+48 && ball.yv > 0 && ball.yv/ball.xv > .1){
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
void mousePressed(){
  if(shot && !endGame){
      ball.unShoot();
      ball.onMouse();
      shot = false;
    }
}
void mouseReleased(){
  if(!endGame){
   if(!shot && time<30){
     ball.shadow();
     ball.shoot();
   }else if(shot)
     ball.unShoot();
  }
}
