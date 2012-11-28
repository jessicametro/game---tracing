color bkgd = #f2f2f2; 
PFont roboto;

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
  background(bkgd);
  frameRate(30);
  smooth();
  img_splash = loadImage("splash.png");
  roboto = loadFont("Roboto-LightItalic-20.vlw");
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
  
}


