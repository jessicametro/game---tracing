color bkgd = #f2f2f2; 



/* STATES */
int STATE_START = 0;
int STATE_INTRO = 1;
int STATE_GAME = 2;
int STATE_DONE = 3;

int currentState = STATE_START;



/* SPLASH */
PImage img_splash;
int splashStart = 60;
int splashEnd = 75;
float splashFadeSpeed = 255.0 / (splashEnd - splashStart);



void setup() {
  size(400, 400);
  smooth();
  img_splash = loadImage("splash.png");
  frameRate(30);
  background(bkgd);
}

void draw() {
  background(bkgd);
  if (currentState == STATE_START) {
    fadeSplashScreen();
  }
}



void goToStateIntro() {
  currentState = STATE_INTRO;
}

void goToStateGame() {
  currentState = STATE_GAME;
}

void goToStateDone() {
  currentState = STATE_DONE;
}



void fadeSplashScreen() {
  if (frameCount < splashStart) {
    drawSplashScreen();
  }
  if (frameCount >= splashStart && frameCount < splashEnd) {
    tint(255, 255 - (frameCount-splashStart) * splashFadeSpeed);
    drawSplashScreen();
  }
  if (frameCount >= splashEnd) {
    goToStateIntro();
  }
}

void drawSplashScreen() {
  image(img_splash, 0, 0);
}


