Menu main;
Basketball ball;
Button newGame;
Hoop hoop;
boolean toggle, shot;
void setup(){
  size(1280,720);
  frameRate(60);
  rectMode(CENTER);
  textAlign(CENTER,CENTER);
  imageMode(CENTER);
  main = new Menu();
  newGame = new Button(640, 405, 426, 90, "New Game");
  toggle = shot = false;
  ball = new Basketball();
  hoop = new Hoop();
}
void draw(){
  if(!toggle){
    main.display();
    toggle = newGame.input();
  }else{
    background(0,255,255);
    if(!mousePressed && !shot){
      ball.onMouse();
    }
    hoop.display();
    ball.display(shot);
    if(mousePressed && !shot){
      ball.drawLine();
    }
    if(ball.y > 720){
      shot=false;
      ball.unShoot();
    }
  }
}
void mouseReleased(){
  if(mouseButton == RIGHT){
    if(!shot){
      ball.shadow();
      ball.shoot();
    }
    shot = true;
  }
  if(mouseButton == LEFT){
    shot = false;
    ball.unShoot();
  }
}
