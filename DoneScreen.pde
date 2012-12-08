/* DONE */


PImage img_win;
PImage img_playagain;

int doneStartFrame;
int winAllFadedIn = 60;
float winFadeInSpeed = 255.0 / winAllFadedIn;

int winStartFadeOut = winAllFadedIn + 90;
int winAllFadedOut = winStartFadeOut + 60;
float winFadeOutSpeed = 255.0 / (winAllFadedOut - winStartFadeOut);

int againAllFadedIn = winAllFadedOut + 90;
float againFadeInSpeed = 255.0 / (againAllFadedIn - winAllFadedOut);


void drawDoneScreen() {
  
  int relativeFrameCount = frameCount - doneStartFrame;
  
  if (relativeFrameCount < winAllFadedIn) {
    drawStatusDots(255);
    tint(255, relativeFrameCount * winFadeInSpeed);
    //tint(255, map(relativeFrameCount, 0, winAllFadedIn, 0, 255));
    image(img_win, 0, 0);  
  } else if (relativeFrameCount >= winAllFadedIn && relativeFrameCount < winStartFadeOut) {
    drawStatusDots(255);
    tint(255);
    image(img_win, 0, 0);  
  } else if (relativeFrameCount >= winStartFadeOut && relativeFrameCount < winAllFadedOut) {
    drawStatusDots(255 - (relativeFrameCount - winStartFadeOut) * winFadeOutSpeed);
    tint(255, 255 - (relativeFrameCount - winStartFadeOut) * winFadeOutSpeed);
    image(img_win, 0, 0);
  } else if (relativeFrameCount >= winAllFadedOut && relativeFrameCount < againAllFadedIn) {
    tint(255, (relativeFrameCount - winAllFadedOut) * againFadeInSpeed);
    image(img_playagain, 0, 0);  
  } else if (relativeFrameCount >= againAllFadedIn) {
    
  }
}
 
