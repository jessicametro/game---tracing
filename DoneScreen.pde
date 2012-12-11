/* DONE */


PImage img_win;
PImage img_playagain;

int doneStartFrame;
int winAllFadedIn = 1000;
float winFadeInSpeed = 255.0 / winAllFadedIn;

int winStartFadeOut = winAllFadedIn + 1500;
int winAllFadedOut = winStartFadeOut + 1000;
float winFadeOutSpeed = 255.0 / (winAllFadedOut - winStartFadeOut);

int againAllFadedIn = winAllFadedOut + 1500;
float againFadeInSpeed = 255.0 / (againAllFadedIn - winAllFadedOut);




void drawDoneScreen() {
  int relativeFrameCount = millis() - doneStartFrame;  
  if (relativeFrameCount < winAllFadedIn) {
    drawStatusDots(255);
    tint(255, relativeFrameCount * winFadeInSpeed);
    image(img_win, 0, 0, 400, 400);  
  } else if (relativeFrameCount >= winAllFadedIn && relativeFrameCount < winStartFadeOut) {
    drawStatusDots(255);
    tint(255);
    image(img_win, 0, 0, 400, 400);  
  } else if (relativeFrameCount >= winStartFadeOut && relativeFrameCount < winAllFadedOut) {
    drawStatusDots(255 - (relativeFrameCount - winStartFadeOut) * winFadeOutSpeed);
    tint(255, 255 - (relativeFrameCount - winStartFadeOut) * winFadeOutSpeed);
    image(img_win, 0, 0, 400, 400);
  } else if (relativeFrameCount >= winAllFadedOut && relativeFrameCount < againAllFadedIn) {
    float opacity = (relativeFrameCount - winAllFadedOut) * againFadeInSpeed;
    tint(255, opacity);
    image(img_playagain, 0, 0, 400, 400);  
    fill(#DDDDDD, opacity);
    rect(40, 300, 150, 60);
    fill(#AAAAAA, opacity);
    textFont(roboto, 24);
    text("yes", 115, 336);
    fill(#DDDDDD, opacity); 
    rect(210, 300, 150, 60);
    fill(#AAAAAA, opacity);
    textFont(roboto, 24);
    text("no", 285, 336);
  } else if (relativeFrameCount >= againAllFadedIn) {
    tint(255);
    image(img_playagain, 0, 0, 400, 400);  
    fill(#DDDDDD);
    rect(40, 300, 150, 60);
    fill(#AAAAAA);
    textFont(roboto, 24);
    text("yes", 115, 336);
    fill(#DDDDDD); 
    rect(210, 300, 150, 60);
    fill(#AAAAAA);
    textFont(roboto, 24);
    text("no", 285, 336);
  }
}
 
