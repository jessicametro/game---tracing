color bkgd = #f2f2f2; 
color textT = #009999;
color textG = #aaaaaa; // same as at the end
color shapeDefault = #CCCCCC;
color userInput = #008888;
color shapeConfirm = #000000; // at 8% opacity or 20.4 : 255
color statusDefault = #DDDDDD;
color statusActive = #BBBBBB; 
color statusComplete = #008888;

PFont roboto;

int pathStrokeWeight = 24;

float scoreMin = 1.1;

// circles = 20 x 20
// 10px of space between each circle


/* STATES */
int STATE_START = 0;
int STATE_INTRO = 1;
int STATE_GAME = 2;
int STATE_DONE = 3;

int currentState = STATE_START;


/* SPLASH */
PImage img_splash;
int splashStart = 120;
int splashEnd = 150;
float splashFadeSpeed = 255.0 / (splashEnd - splashStart);


/* INTRO */
RCurve introCurve;
int introFrameCount;
DollarRecognizer introDOR = new DollarRecognizer();  // gesture recognition
ArrayList<Point> userPath = new ArrayList<Point>();  // this is the container for points the user inputs
boolean introSuccess = false;
int introSuccessFrame;
int introEnd = 120;


/* GAME */
GameLevel level = new GameLevel();

class GameLevel {
  int number;
  String name;
  int startFrame;
  RCurve curve;
  DollarRecognizer recognizer = new DollarRecognizer();  // gesture recognition
  ArrayList<Point> userPath = new ArrayList<Point>();  // this is the container for points the user inputs
  boolean success;
  int successFrame;
  float scoreMin;
  float scoreUser;
}


/* DONE */



void setup() {
  size(400, 400);
  background(bkgd);
  frameRate(60);
  smooth();
  img_splash = loadImage("splash.png");
  roboto = loadFont("Roboto-LightItalic-20.vlw");
  introCurve = new RCurve();
  introCurve.createPoints(3.0, 40, 90, 40, 90, 360, 340, 360, 340);
  introDOR.addGesture("intro", introCurve.points);  // gesture recognition, passes points from RCurve
  setupGameLevel1();
}


/*
void setupLevel(GameLevel level, RCurve myCurve) {
  level.curve = myCurve;
  level.recognizer.addGesture(name, level.curve.points);
}
*/


void setupGameLevel1() {
  level.number = 1;
  level.name = "One";
  level.startFrame = 0;
  level.curve = new RCurve();
  level.curve.createPoints(3.0, 40, 90, 40, 90, 360, 340, 360, 340);
  level.recognizer.addGesture(level.name, level.curve.points);
  level.success = false;
  
}


void draw() {
  background(bkgd);
  if (currentState == STATE_START) {
    drawSplashScreen();
  }
  if (currentState == STATE_INTRO) {
    drawIntroScreen();
  }
  if (currentState == STATE_GAME) {
    drawGameScreen();
  }
}



void goToStateIntro() {
  currentState = STATE_INTRO;
  println("We're now introducing the game.");
  introFrameCount = frameCount;
}

void goToStateGame() {
  currentState = STATE_GAME;
  println("We're now playing the game.");
  goToLevel(1);
}

void goToLevel(int levelNumber) {
  level.startFrame = frameCount;
}

void goToStateDone() {
  currentState = STATE_DONE;
  println("We're now deciding to play again or leave.");
}



void drawSplashScreen() {
  if (frameCount < splashStart) {
    image(img_splash, 0, 0);
  }
  if (frameCount >= splashStart && frameCount < splashEnd) {
    tint(255, 255 - (frameCount-splashStart) * splashFadeSpeed);
    image(img_splash, 0, 0);
  }
  if (frameCount >= splashEnd) {
    goToStateIntro();
  }
}



void drawIntroScreen() {
  textAlign(CENTER);
  fill(#009999);
  textFont(roboto);
  text("trace the shape", 200, 45);  
  if (frameCount - introFrameCount < 150) {
    float startPathIntro = ((frameCount - introFrameCount))/100.0;
    introCurve.drawCurve(startPathIntro, 0.4, shapeDefault, pathStrokeWeight);
  }  
  noFill();
  stroke(userInput);
  strokeWeight(pathStrokeWeight);
  strokeJoin(ROUND);
  beginShape();
    for (int i = 0; i < userPath.size(); i++) {
      vertex(userPath.get(i).X, userPath.get(i).Y);  // array = userPath[i].x but this uses X also an array list = userPath.get(i).X
    }
  endShape();
  if (introSuccess == true) {
    image(img_splash, 0, 0);  // DON'T FORGET TO UPDATE THIS IMAGE!
  }
  if (introSuccess == true && (frameCount - introSuccessFrame) >= introEnd) {
    goToStateGame();
  }
}



/* user's input */
void mouseDragged() { 
  userPath.add(new Point(mouseX, mouseY));
}
void mouseReleased() {
  Result val = introDOR.recognize(userPath, true); 
  println("Recnogized: "+val.name+" Score:" +val.score);
  if (val.score > scoreMin) {
    println("Success!");
    introSuccess = true;
    introSuccessFrame = frameCount;
  }
  userPath.clear();
}



void drawGameScreen() {
  if (frameCount - level.startFrame < 150) {
    float startPathIntro = ((frameCount - level.startFrame))/100.0;
    level.curve.drawCurve(startPathIntro, 0.4, shapeDefault, pathStrokeWeight);
  } 
}

