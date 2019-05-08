Menu main;
boolean gameRunning;
void setup(){
  size(1280,720);
  frameRate(60);
  rectMode(CENTER);
  textAlign(CENTER,CENTER);
  imageMode(CENTER);
  main = new Menu();
  gameRunning = false;
}
void draw(){ 
  gameRunning = main.display(gameRunning);
  if(gameRunning){
    println("Game Running");
  }else{
    println("Game Not Running"); 
  }
}
