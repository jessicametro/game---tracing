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


void setup() {
  size(400, 400);
  background(bkgd);
  frameRate(60);
  smooth();
  img_splash = loadImage("splash.png");
  roboto = loadFont("Roboto-LightItalic-20.vlw");
  introCurve = new RCurve();
  introCurve.createPoints(1.0, 40, 90, 40, 90, 360, 340, 360, 340);
}

void draw() {
  background(bkgd);
  if (currentState == STATE_START) {
    drawSplashScreen();
  }
  if (currentState == STATE_INTRO) {
    drawIntroScreen();
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
  /*int demoIntroTimeout = if (frameCount > 150) {
    stop the animation;
  }
  float startPathIntro = ((frameCount - introFrameCount) % demoIntroTimeout/100.0; // change 150
  float startPathIntro = ((frameCount - introFrameCount) % if (frameCount < 150) { draw the curve} else { wait for input })/100.0;
  //float startPathIntro = ((frameCount - introFrameCount) % 150)/100.0; // change 150
  introCurve.drawCurve(startPathIntro, 0.4, shapeDefault, pathStrokeWeight); */
  
  if (frameCount < 150) {
    startPathIntro;
  } else {
    end?;
  }
  float startPathIntro = ((frameCount - introFrameCount) % 150)/100.0;
  introCurve.drawCurve(startPathIntro, 0.4, shapeDefault, pathStrokeWeight);
}



For the first atartFrameCoint frames, draw it with full opacity
Between startFrameVound and wndFrameCount make it fade
And after endFrameCount wait for the usrt to draw stuff









