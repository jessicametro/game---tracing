/* SPLASH */


PImage img_splash;
int splashStart = 2000;
int splashEnd = 2500;
float splashFadeSpeed = 255.0 / (splashEnd - splashStart);


void drawSplashScreen() {
  if (millis() < splashStart) {
    image(img_splash, 0, 0, 400, 400);
  }
  if (millis() >= splashStart && millis() < splashEnd) {
    tint(255, 255 - (millis()-splashStart) * splashFadeSpeed);
    image(img_splash, 0, 0, 400, 400);
  }
  if (millis() >= splashEnd) {
    goToStateIntro();
  }
}
