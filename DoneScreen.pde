/* DONE */


PImage img_win;

int doneStartFrame;
int winAllFadedIn = 60;
float winFadeInSpeed = 255.0 / winAllFadedIn;

int winStartFadeOut = winAllFadedIn + 90;
int winAllFadedOut = winStartFadeOut + 60;
float winFadeOutSpeed = 255.0 / (winAllFadedOut - winStartFadeOut);

int againAllFadedIn = winAllFadedOut + 90;


void drawDoneScreen() {
  
  int relativeFrameCount = frameCount - doneStartFrame;
  
  if (relativeFrameCount < winAllFadedIn) {
    drawStatusDots();
    tint(255, relativeFrameCount * winFadeInSpeed);
    //tint(255, map(relativeFrameCount, 0, winAllFadedIn, 0, 255));
    image(img_win, 0, 0);  
  } else if (relativeFrameCount >= winAllFadedIn && relativeFrameCount < winStartFadeOut) {
    drawStatusDots();
    tint(255);
    image(img_win, 0, 0);  
  } else if (relativeFrameCount >= winStartFadeOut && relativeFrameCount < winAllFadedOut) {
    drawStatusDots();
    tint(255, 255 - (relativeFrameCount - winStartFadeOut) * winFadeOutSpeed);
    image(img_win, 0, 0);
  } else if (relativeFrameCount >= winAllFadedOut && relativeFrameCount < againAllFadedIn) {
    
  } else if (relativeFrameCount >= againAllFadedIn) {
    
  }
}
 
