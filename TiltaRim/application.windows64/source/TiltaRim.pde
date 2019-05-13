Menu main;
EndGame end;
Basketball ball;
Button newGame;
Hoop hoop;
boolean gameRunning, endGame, shot;
int score,time;
PFont fontScore;
void setup(){
  size(1280,720);
  frameRate(60);
  rectMode(CENTER);
  textAlign(CENTER,CENTER);
  imageMode(CENTER);
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
      background(0,255,255);
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
      if(ball.y > 720){
        ball.unShoot();
      }
      if(ball.x > 1200 && ball.x < 1264 && ball.y> hoop.y-48 && ball.y < hoop.y+48 && ball.yv > 0){
        score++;
        hoop.newPos();
        ball.unShoot();
      }else if(ball.x>1280){
        ball.unShoot();
      }
      if(frameCount%60==0 && !endGame)
        time-=1;
      if(time<1){
        endGame=true;
      }
    if(endGame){
      end.display(score);
    }
  }
}
void mousePressed(){
  if(shot && !endGame){
      ball.x = mouseX;
      ball.y = mouseY;
      ball.unShoot();
      shot = false;
    }
}
void mouseReleased(){
  if(!endGame){
   if(!shot && time<30){
     ball.shadow();
     ball.shoot();
   }else if(shot){
     ball.unShoot();
   }
  }
}
