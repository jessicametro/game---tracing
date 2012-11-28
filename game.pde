color bkgd = #f2f2f2; 

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
  fadeSplashScreen();
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
    tint(255, 0);
  }
}

void drawSplashScreen() {
  image(img_splash, 0, 0);
}
