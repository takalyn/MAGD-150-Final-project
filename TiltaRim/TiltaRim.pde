Menu main;
Basketball ball;
Button newGame;
Hoop hoop;
int count;
boolean toggle;
void setup(){
  size(1280,720);
  frameRate(60);
  rectMode(CENTER);
  textAlign(CENTER,CENTER);
  imageMode(CENTER);
  main = new Menu();
  newGame = new Button(640, 405, 426, 90, "New Game");
  toggle = false;
  ball = new Basketball();
}
void draw(){
  if(!toggle){
    main.display();
    toggle = newGame.input();
  }else{
    background(0,255,255);//game goes here
    ball.display();
    if(count%60 == 0){println("game "+count/60);}
    count++;
  }
}
