/* INTRO */


PImage img_great;
PImage img_tryagain;
RCurve introCurve;
int introFrameCount;

DollarRecognizer introDOR = new DollarRecognizer();  // gesture recognition
ArrayList<Point> userPath = new ArrayList<Point>();  // this is the container for points the user inputs

boolean allowUserInput = false;

boolean introFinished;
int introFinishedFrame;
boolean introSuccess = false;
int introSuccessFrame;
int introEnd = 2000;


void drawIntroScreen() {
  textAlign(CENTER);
  fill(#009999);
  textFont(roboto_italic, 20);
  text("trace the shape", 200, 45);  
  if (millis() - introFrameCount < 2500) {
    float startPathIntro = ((millis() - introFrameCount))/1600.0;
    introCurve.drawCurve(startPathIntro, 0.4, shapeDefault, pathStrokeWeight);
  } else if (introFinished == false && introSuccess == false) { // this is between when the game draws the shape and the confirmation // where the user can make their input
    allowUserInput = true;  // enable user input now
    if (userPath.size() >= 1) {  // wrapping the following info in an if statement makes the user input go away on the next round on Android
      noFill();
      stroke(userInput);
      strokeWeight(pathStrokeWeight);
      strokeJoin(ROUND);
      beginShape();
        for (int i = 0; i < userPath.size(); i++) {
          vertex(userPath.get(i).X, userPath.get(i).Y);  // array = userPath[i].x but this uses X also an array list = userPath.get(i).X
        }
      endShape();
    }
  } else {
    allowUserInput = false;  // disable user input again so user can't draw on confirmation screens
  }
  if (introFinished == true && introSuccess == false) {
    tint(255);
    image(img_tryagain, 0, 0, 400, 400);
  }
  if (introFinished == true && introSuccess == false && (millis() - introFinishedFrame) >= introEnd) {
    restartIntro();
  }
  if (introSuccess == true) {
    tint(255);
    image(img_great, 0, 0, 400, 400);
  }
  if (introSuccess == true && (millis() - introSuccessFrame) >= introEnd) {
    goToStateGame();
  }
}


