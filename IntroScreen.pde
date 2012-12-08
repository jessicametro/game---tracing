/* INTRO */


PImage img_great;
RCurve introCurve;
int introFrameCount;
DollarRecognizer introDOR = new DollarRecognizer();  // gesture recognition
ArrayList<Point> userPath = new ArrayList<Point>();  // this is the container for points the user inputs
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
    image(img_great, 0, 0);  // DON'T FORGET TO UPDATE THIS IMAGE!
    tint(255);
  }
  if (introSuccess == true && (frameCount - introSuccessFrame) >= introEnd) {
    goToStateGame();
  }
}


