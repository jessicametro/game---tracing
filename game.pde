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

// circles = 20 x 20
// 10px of space between each circle




/* STATES */
int STATE_START = 0;
int STATE_INTRO = 1;
int STATE_GAME = 2;
int STATE_DONE = 3;

int currentState = STATE_START;




void setup() {
  size(400, 400);
  background(bkgd);
  frameRate(60);
  smooth();
  img_splash = loadImage("splash.png");
  img_great = loadImage("great.png");
  img_win = loadImage("win.png");
  img_playagain = loadImage("playagain.png");
  roboto_italic = loadFont("Roboto-LightItalic-20.vlw");
  roboto = loadFont("Roboto-Light-24.vlw");
  introCurve = new RCurve();
  introCurve.createPoints(3.0, 40, 90, 40, 90, 360, 340, 360, 340);
  introDOR.addGesture("intro", introCurve.points);  // gesture recognition, passes points from RCurve 
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
  if (currentState == STATE_DONE) {
    drawDoneScreen();
  }
}




/******************** This is the land of control. we shall not draw anything in this sacred ground ********************/

void goToStateIntro() {
  currentState = STATE_INTRO;
  println("We're now introducing the game.");
  introFrameCount = frameCount;
}

void goToStateGame() {
  currentState = STATE_GAME;
  println("We're now playing the game.");
  goToLevel(0);
}

void goToLevel(int levelNumber) {
  if (levelNumber < 10) {          // This is the total number of levels!
    level = createGameLevel(levelNumber);
  } //else if (level.number == 9 && level.success == true) {
//    background(bkgd);
//    image(img_win, 0, 0);
//    tint(255);
//    noStroke();
//    fill(statusComplete);
//    ellipse(51, 40, 20, 20);
//    ellipse(84, 40, 20, 20);
//    ellipse(117, 40, 20, 20);
//    ellipse(150, 40, 20, 20);
//    ellipse(183, 40, 20, 20);
//    ellipse(216, 40, 20, 20);
//    ellipse(249, 40, 20, 20);
//    ellipse(282, 40, 20, 20);
//    ellipse(315, 40, 20, 20);
//    ellipse(348, 40, 20, 20);
//  } 
  else {
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

void mouseDragged() { 
  if (currentState == STATE_INTRO) {
    userPath.add(new Point(mouseX, mouseY));
  } else if (currentState == STATE_GAME) {
   level.userPath.add(new Point(mouseX, mouseY));
  }
}

void mouseReleased() {
  if (currentState == STATE_INTRO) {
    Result val = introDOR.recognize(userPath, true); 
    println("Recnogized: "+val.name+" Score:" +val.score);
    if (val.score > scoreMin) {
      println("Success!");
      introSuccess = true;
      introSuccessFrame = frameCount;
    }
    userPath.clear();
  } else if (currentState == STATE_GAME) {
    Result val = level.recognizer.recognize(level.userPath, true); 
    println("Recnogized: "+val.name+" Score:" +val.score);
    if (val.score > level.scoreMin) {
      println("Success!");
      level.success = true;
      level.scoreUser = val.score;
    }
    level.finishedFrame = frameCount;
    level.finished = true;
  }
}

void mouseClicked() {
  if (currentState == STATE_DONE) {
    println("the user has clicked on the done screen");
    if (mouseX >= 40 && mouseX <= 180 && mouseY >= 300 && mouseY <= 360) {
      println("return to game");
      goToStateGame(); 
    }
    if (mouseX >= 210 && mouseX <= 360 && mouseY >= 300 && mouseY <= 360) {
      println("goodbye");
      exit();
    }
  }
  
}










