color bkgd = #f2f2f2; 
color textT = #009999;
color textG = #aaaaaa; // same as at the end
color shapeDefault = #CCCCCC;
color userInput = #008888;
color shapeConfirm = #000000; // at 8% opacity or 20.4 : 255  ... actually #CCCCCC at 50%
color statusDefault = #DDDDDD;
color statusActive = #BBBBBB; 
color statusComplete = #008888;

PFont roboto_italic;
PFont roboto;

int pathStrokeWeight = 24;

float scoreMin = 1.1;

float s;
float left;
float top;


/* STATES */
int STATE_START = 0;
int STATE_INTRO = 1;
int STATE_GAME = 2;
int STATE_DONE = 3;

int currentState = STATE_START;


void setup() {
  size(600, 600);
  //size(displayWidth, displayHeight);
  background(bkgd);
  frameRate(60);
  smooth();
  img_splash = loadImage("splash_x2.png");
  img_tryagain = loadImage("tryagain_x2.png");
  img_great = loadImage("great_x2.png");
  img_win = loadImage("win_x2.png");
  img_playagain = loadImage("playagain_x2.png");
  roboto_italic = loadFont("Roboto-LightItalic-20.vlw");
  roboto = loadFont("Roboto-Light-24.vlw");
  introCurve = new RCurve();
  introCurve.createPoints(3.0, 40, 90, 40, 90, 360, 340, 360, 340);
  introDOR.addGesture("intro", introCurve.points);  // gesture recognition, passes points from RCurve 
}

void draw() {
  calculateScale();
  translate(left, top);
  scale(s, s);
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
  if (currentState == STATE_DONE) {
    drawDoneScreen();
  }
}

void calculateScale() {
  float smallestSide = min(width, height);
  s = smallestSide/400;
  left = (width-smallestSide)/2;
  top = (height-smallestSide)/2;
}



/******************** This is the land of control. we shall not draw anything in this sacred ground ********************/

void goToStateIntro() {
  currentState = STATE_INTRO;
  println("We're now introducing the game.");
  introFrameCount = frameCount;
}

void restartIntro() {
  introFrameCount = frameCount;
  introFinished = false;
}

void goToStateGame() {
  currentState = STATE_GAME;
  println("We're now playing the game.");
  goToLevel(0);
}

void goToLevel(int levelNumber) {
  if (levelNumber < 10) {          // This is the total number of levels!
    level = createGameLevel(levelNumber);
  } else {
    goToStateDone();
  }
  level.startFrame = frameCount;
}

void restartLevel() {
  level.userPath.clear();
  level.startFrame = frameCount;
  level.success = false;
  level.finished = false;
}

void goToStateDone() {
  currentState = STATE_DONE;
  println("We're now deciding to play again or leave.");
  doneStartFrame = frameCount;
}

/*********************************** Nowe we can draw things ***********************************/




/* user's input */

float actualMouseX() {  // this is for the scale
  return (mouseX-left)/s ;
}

float actualMouseY() {  // this is for the scale
  return (mouseY-top)/s;
}

void mouseDragged() { 
  if (currentState == STATE_INTRO) {
    userPath.add(new Point(actualMouseX(), actualMouseY()));
  } else if (currentState == STATE_GAME) {
   level.userPath.add(new Point(actualMouseX(), actualMouseY()));
  }
}

void mouseReleased() {
  if (currentState == STATE_INTRO) {
    if (userPath.size() >= 2) {
      Result val = introDOR.recognize(userPath, true); 
      println("Recnogized: "+val.name+" Score:" +val.score);
      if (val.score > scoreMin) {
        println("Success!");
        introSuccess = true;
        introSuccessFrame = frameCount;
      } else if (val.score < scoreMin) {
        println("Failure!");
        introFinished = true;
        introFinishedFrame = frameCount;
        introSuccess = false;
      }
    }
    userPath.clear();
  } else if (currentState == STATE_GAME) {
    if (level.userPath.size() >= 2) {
      Result val = level.recognizer.recognize(level.userPath, true); 
      println("Recnogized: "+val.name+" Score:" +val.score);
      if (val.score > level.scoreMin) {
        println("Success!");
        level.success = true;
        level.scoreUser = val.score;
      }
    }
    level.finishedFrame = frameCount;
    level.finished = true;
  }
}

void mouseClicked() {
  if (currentState == STATE_DONE) {
    println("the user has clicked on the done screen");
    if (actualMouseX() >= 40 && actualMouseX() <= 180 && actualMouseY() >= 300 && actualMouseY() <= 360) {
      println("return to game");
      goToStateGame(); 
    }
    if (actualMouseX() >= 210 && actualMouseX() <= 360 && actualMouseY() >= 300 && actualMouseY() <= 360) {
      println("goodbye");
      exit();
    }
  }
  
}


