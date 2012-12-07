/* SPLASH */


PImage img_splash;
int splashStart = 120;
int splashEnd = 150;
float splashFadeSpeed = 255.0 / (splashEnd - splashStart);


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
