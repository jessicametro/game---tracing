/* INTRO */


PImage img_great;
PImage img_tryagain;
RCurve introCurve;
int introFrameCount;

DollarRecognizer introDOR = new DollarRecognizer();  // gesture recognition
ArrayList<Point> userPath = new ArrayList<Point>();  // this is the container for points the user inputs

boolean introFinished;
int introFinishedFrame;
boolean introSuccess = false;
int introSuccessFrame;
int introEnd = 120;


void drawIntroScreen() {
  textAlign(CENTER);
  fill(#009999);
  textFont(roboto_italic);
  text("trace the shape", 200, 45);  
  if (frameCount - introFrameCount < 150) {
    float startPathIntro = ((frameCount - introFrameCount))/100.0;
    introCurve.drawCurve(startPathIntro, 0.4, shapeDefault, pathStrokeWeight);
  }  
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
  if (introFinished == true && introSuccess == false) {
    tint(255);
    image(img_tryagain, 0, 0, 400, 400);
  }
  if (introFinished == true && introSuccess == false && (frameCount - introFinishedFrame) >= introEnd) {
    restartIntro();
  }
  if (introSuccess == true) {
    tint(255);
    image(img_great, 0, 0, 400, 400);
  }
  if (introSuccess == true && (frameCount - introSuccessFrame) >= introEnd) {
    goToStateGame();
  }
}


