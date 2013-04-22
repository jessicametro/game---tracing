/* LIBRARIES USED:
  $1 Unistroke Recognizer : DollarOneRecognizer : Jacob O. Wobbrock, Andrew D. Wilson, Yang Li : http://depts.washington.edu/aimgroup/proj/dollar
  RCurve : RJ Marsan : http://rsrch1.rjmarsan.com/rCurves.pde
*/

color bkgd = #f2f2f2; 
color textT = #009999;
color textG = #aaaaaa; // same as at the end
color shapeDefault = #CCCCCC;
color userInput = #008888;
color shapeConfirm = #000000; // at 8% opacity or 20.4 : 255  ... actually #CCCCCC at 50%
color statusDefault = #DDDDDD;
color statusActive = #BBBBBB; 
color statusComplete = #008888;

PFont roboto_italic;
PFont roboto;

int pathStrokeWeight = 24;

float scoreMin = 0.7;//1.1;

float s;
float left;
float top;


/* STATES */
int STATE_START = 0;
int STATE_INTRO = 1;
int STATE_GAME = 2;
int STATE_DONE = 3;

int currentState = STATE_START;


void setup() {
  size(800, 800);
  //size(displayWidth, displayHeight);
  size(window.innerWidth, window.innerHeight); //processingjs only
  calculateScale();
  background(bkgd);
  frameRate(60);
  smooth();
  img_splash = loadImage("splash_x2.png");
  img_tryagain = loadImage("tryagain_x2.png");
  img_great = loadImage("great_x2.png");
  img_win = loadImage("win_x2.png");
  img_playagain = loadImage("playagain_x2.png");
  roboto_italic = createFont("Roboto-LightItalic", 20*s, true);
  //roboto_italic = loadFont("Roboto-LightItalic-20.vlw");
  roboto = createFont("Roboto-Light", 24*s, true);
  //roboto = loadFont("Roboto-Light-24.vlw");
  introCurve = new RCurve();
  introCurve.createPoints_manual(3.0, 40, 90, 40, 90, 360, 340, 360, 340);
  introDOR.addGesture_floats("intro", introCurve.points);  // gesture recognition, passes points from RCurve 
}

void draw() {
  calculateScale();
  translate(left, top);
  scale(s, s);
  background(bkgd);
  if (currentState == STATE_START) {
    drawSplashScreen();
  }
  if (currentState == STATE_INTRO) {
    drawIntroScreen();
  }
  if (currentState == STATE_GAME) {
    drawGameScreen();
  }
  if (currentState == STATE_DONE) {
    drawDoneScreen();
  }
}

void calculateScale() {
  float smallestSide = min(width, height);
  s = smallestSide/400;
  left = (width-smallestSide)/2;
  top = (height-smallestSide)/2;
}



/******************** This is the land of control. we shall not draw anything in this sacred ground ********************/

void goToStateIntro() {
  currentState = STATE_INTRO;
  debugprint("We're now introducing the game.");
  introFrameCount = millis();
}

void restartIntro() {
  introFrameCount = millis();
  introFinished = false;
}

void goToStateGame() {
  currentState = STATE_GAME;
  debugprint("We're now playing the game.");
  goToLevel(0);
}

void goToLevel(int levelNumber) {
  if (levelNumber < 10) {          // This is the total number of levels!
    level = createGameLevel(levelNumber);
  } else {
    goToStateDone();
  }
  level.startFrame = millis();
}

void restartLevel() {
  level.userPath.clear();
  level.startFrame = millis();
  level.success = false;
  level.finished = false;
}

void goToStateDone() {
  currentState = STATE_DONE;
  debugprint("We're now deciding to play again or leave.");
  doneStartFrame = millis();
}

/*********************************** Nowe we can draw things ***********************************/




/* user's input */

float actualMouseX() {  // this is for the scale
  return (mouseX-left)/s ;
}

float actualMouseY() {  // this is for the scale
  return (mouseY-top)/s;
}

void mouseDragged() { 
  if (currentState == STATE_INTRO && allowUserInput == true) {
    userPath.add(new Point(actualMouseX(), actualMouseY()));
  } else if (currentState == STATE_GAME && level.allowUserInput == true) {
   level.userPath.add(new Point(actualMouseX(), actualMouseY()));
  }
}

void mouseReleased() {
  debugprint("Mouse released");
  if (currentState == STATE_INTRO) {
    if (userPath.size() >= 2) {
      Result val = introDOR.recognize(userPath, true); 
      //throw new Exception();
      debugprint("Recnogized: "+val.name+" Score:" +val.score);
      if (val.score > scoreMin) {
        debugprint("Success!");
        introSuccess = true;
        introSuccessFrame = millis();
      } else if (val.score < scoreMin) {
        debugprint("Failure!");
        introFinished = true;
        introFinishedFrame = millis();
        introSuccess = false;
      }
    }
    userPath.clear();
  } else if (currentState == STATE_GAME) {
    if (level.userPath.size() >= 2) {
      Result val = level.recognizer.recognize(level.userPath, true); 
      debugprint("Recnogized: "+val.name+" Score:" +val.score);
      if (val.score > level.scoreMin) {
        debugprint("Success!");
        level.success = true;
        level.scoreUser = val.score;
      }
      level.finishedFrame = millis();
      level.finished = true;
    }
  }
}

void mouseClicked() {
  if (currentState == STATE_DONE) {
    debugprint("the user has clicked on the done screen");
    if (actualMouseX() >= 40 && actualMouseX() <= 180 && actualMouseY() >= 300 && actualMouseY() <= 360) {
      debugprint("return to game");
      goToStateGame(); 
    }
    if (actualMouseX() >= 210 && actualMouseX() <= 360 && actualMouseY() >= 300 && actualMouseY() <= 360) {
      debugprint("goodbye");
      exit();
    }
  }
  
}






void debugprint(String toprint) {
  //println(toprint);
  
}


/**
 * The $1 Unistroke Recognizer (Processing version)
 *
 *  RJ Marsan
 *  Based on $1 Unistroke Recognizer by:
 *
 *  Jacob O. Wobbrock, Ph.D.
 *   The Information School
 *  University of Washington
 *  Seattle, WA 98195-2840
 *  wobbrock@uw.edu
 *
 *  Andrew D. Wilson, Ph.D.
 *  Microsoft Research
 *  One Microsoft Way
 *  Redmond, WA 98052
 *  awilson@microsoft.com
 *
 *  Yang Li, Ph.D.
 *  Department of Computer Science and Engineering
 *   University of Washington
 *  Seattle, WA 98195-2840
 *   yangli@cs.washington.edu
 *
 * The academic publication for the $1 recognizer, and what should be 
 * used to cite it, is:
 *
 *  Wobbrock, J.O., Wilson, A.D. and Li, Y. (2007). Gestures without 
 *    libraries, toolkits or training: A $1 recognizer for user interface 
 *    prototypes. Proceedings of the ACM Symposium on User Interface 
 *    Software and Technology (UIST '07). Newport, Rhode Island (October 
 *    7-10, 2007). New York: ACM Press, pp. 159-168.
 *
 * The Protractor enhancement was separately published by Yang Li and programmed 
 * here by Jacob O. Wobbrock:
 *
 *  Li, Y. (2010). Protractor: A fast and accurate gesture
 *    recognizer. Proceedings of the ACM Conference on Human
 *    Factors in Computing Systems (CHI '10). Atlanta, Georgia
 *    (April 10-15, 2010). New York: ACM Press, pp. 2169-2172.
 *
 * This software is distributed under the "New BSD License" agreement:
 *
 * Copyright (C) 2007-2012, Jacob O. Wobbrock, Andrew D. Wilson and Yang Li.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    * Neither the names of the University of Washington nor Microsoft,
 *      nor the names of its contributors may be used to endorse or promote
 *      products derived from this software without specific prior written
 *      permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Jacob O. Wobbrock OR Andrew D. Wilson
 * OR Yang Li BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
 * OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/
 
//
// DollarRecognizer class constants
//
int NumUnistrokes = 16;
int NumPoints = 64;
float SquareSize = 250.0;
Point Origin = new Point(0, 0);
float Diagonal = sqrt(SquareSize * SquareSize + SquareSize * SquareSize);
float HalfDiagonal = 0.5 * Diagonal;
float AngleRange = Deg2Rad(45.0);
float AnglePrecision = Deg2Rad(2.0);
float Phi = 0.5 * (-1.0 + sqrt(5.0)); // Golden Ratio
 
 
//
// Unistroke class: a unistroke template
//
class Unistroke {
  public String Name;
  public Point[] Points;
  public float[] Vector;

  public Unistroke(String name, Point[] points) {
    this.Name = name;
    this.Points = Resample(points, NumPoints);
    float radians = IndicativeAngle(this.Points);
    this.Points = RotateBy(this.Points, -radians);
    this.Points = ScaleTo(this.Points, SquareSize);
    this.Points = TranslateTo(this.Points, Origin);
    this.Vector = Vectorize(this.Points); // for Protractor
  }
}

//
// Result class
//
class Result {
  String name;
  float score;

  public Result(String name, float score) {
    this.name = name;
    this.score = score;
  }
}

Point[] toArray(ArrayList<Point> points) {
  Point[] out = new Point[points.size()];
  for (int i=0; i<points.size(); i++) {
     out[i] = points.get(i); 
  }
  return out;
}

//
// DollarRecognizer class
//
class DollarRecognizer { 
  ArrayList<Unistroke> Unistrokes = new ArrayList<Unistroke>();

  public DollarRecognizer() {
    //
    // one built-in unistroke per gesture type
    //
  }

  //
  // The $1 Gesture Recognizer API begins here -- 3 methods: Recognize(), AddGesture(), and DeleteUserGestures()
  //
  public Result recognize(ArrayList<Point> points, boolean useProtractor) {
    return recognize_inner(toArray(points), useProtractor);
  }
  public Result recognize_inner(Point[] points, boolean useProtractor) {
    points = Resample(points, NumPoints);
    float radians = IndicativeAngle(points);
    points = RotateBy(points, -radians);
    points = ScaleTo(points, SquareSize);
    points = TranslateTo(points, Origin);
    float[] vector = Vectorize(points); // for Protractor

    float b = 999999;
    int u = -1;
    for (int i = 0; i < this.Unistrokes.size(); i++) // for each unistroke
    {
      float d;
      if (useProtractor) // for Protractor
        d = OptimalCosineDistance(this.Unistrokes.get(i).Vector, vector);
      else // Golden Section Search (original $1)
        d = DistanceAtBestAngle(points, this.Unistrokes.get(i), -AngleRange, +AngleRange, AnglePrecision);
      if (d < b) {
        b = d; // best (least) distance
        u = i; // unistroke
      }
    }
    return (u == -1) ? new Result("No match.", 0.0) : new Result(this.Unistrokes.get(u).Name, useProtractor ? 1.0 / b : 1.0 - b / HalfDiagonal);
  }
  
  public int addGesture_floats(String name, float[] floats) {
    Point[] points = new Point[floats.length/2];
    for (int i=0; i<floats.length; i+=2) {
      points[i/2] = new Point(floats[i], floats[i+1]); 
    }
    return addGesture_points(name, points);
  }
  
  public int addGesture_points(String name, Point[] points) {
    this.Unistrokes.add(new Unistroke(name, points)); // append new unistroke
    int num = 0;
    for (int i = 0; i < this.Unistrokes.size(); i++) {
      if (this.Unistrokes.get(i).Name.equals(name))
        num++;
    }
    return num;
  }
  
  
  public int deleteUserGestures() {
//        this.Unistrokes.length = NumUnistrokes; // clear any beyond the original set
//        return NumUnistrokes;
    return -1; //NOT IMPLEMENTED YET
  }
}


//
// Private helper functions from this point down
//
Point[] Resample(Point[] pointsx, int n) {
  ArrayList<Point> points = new ArrayList<Point>();
  for (int i=0; i< pointsx.length; i++) points.add(pointsx[i]); //Arrays.asList(pointsx));
  float I = PathLength(pointsx) / (n - 1); // interval length
  float D = 0.0;
  ArrayList<Point> newpoints = new ArrayList();
  newpoints.add(points.get(0));
  for (int i = 1; i < points.size(); i++) {
    float d = Distance(points.get(i - 1), points.get(i));
    if ((D + d) >= I) {
      float qx = points.get(i - 1).X + ((I - D) / d) * (points.get(i).X - points.get(i - 1).X);
      float qy = points.get(i - 1).Y + ((I - D) / d) * (points.get(i).Y - points.get(i - 1).Y);
      Point q = new Point(qx, qy);
      newpoints.add(q); // append new point 'q'
      points.add(i, q); // insert 'q' at position i in points s.t. 'q' will be the next i
      D = 0.0;
    }
    else D += d;
  }
  if (newpoints.size() == n - 1) // somtimes we fall a rounding-error short of adding the last point, so add it if so
  newpoints.add(new Point(points.get(points.size() - 1).X, points.get(points.size() - 1).Y));
  return toArray(newpoints);
}

float IndicativeAngle(Point[] points) {
  Point c = Centroid(points);
  return atan2(c.Y - points[0].Y, c.X - points[0].X);
}

Point[] RotateBy(Point[] points, float radians) {
  Point c = Centroid(points);
  float ncos = cos(radians);
  float nsin = sin(radians);
  ArrayList<Point> newpoints = new ArrayList<Point>();
  for (int i = 0; i < points.length; i++) {
    float qx = (points[i].X - c.X) * ncos - (points[i].Y - c.Y) * nsin + c.X;
    float qy = (points[i].X - c.X) * nsin + (points[i].Y - c.Y) * ncos + c.Y;
    newpoints.add(new Point(qx, qy));
  }
  return toArray(newpoints);
}

Point[] ScaleTo(Point[] points, float size) { // non-uniform scale; assumes 2D gestures (i.e., no lines)
  Rectangle B = BoundingBox(points);
  ArrayList<Point> newpoints = new ArrayList<Point>();
  for (int i = 0; i < points.length; i++) {
    float qx = points[i].X * (size / B.Width);
    float qy = points[i].Y * (size / B.Height);
    newpoints.add(new Point(qx, qy));
  }
  return toArray(newpoints);
}

Point[] TranslateTo(Point[] points, Point pt) { // translates points' centroid
  Point c = Centroid(points);
  ArrayList<Point> newpoints = new ArrayList<Point>();
  for (int i = 0; i < points.length; i++) {
    float qx = points[i].X + pt.X - c.X;
    float qy = points[i].Y + pt.Y - c.Y;
    newpoints.add(new Point(qx, qy));
  }
  return toArray(newpoints);
}

float[] Vectorize(Point[] points) { // for Protractor
  float sum = 0.0;
  float[] vector = new float[points.length*2];
  for (int i = 0; i < points.length; i++) {
    vector[i*2+0] = points[i].X;
    vector[i*2+1] = points[i].Y;
    sum += points[i].X * points[i].X + points[i].Y * points[i].Y;
  }
  float magnitude = sqrt(sum);
  for (int i = 0; i < vector.length; i++)
    vector[i] /= magnitude;
  return vector;
}

float OptimalCosineDistance(float[] v1, float[] v2) { // for Protractor
  float a = 0.0;
  float b = 0.0;
  for (int i = 0; i < v1.length; i += 2) {
    a += v1[i] * v2[i] + v1[i + 1] * v2[i + 1];
    b += v1[i] * v2[i + 1] - v1[i + 1] * v2[i];
  }
  float angle = atan(b / a);
  return acos(a * cos(angle) + b * sin(angle));
}

float DistanceAtBestAngle(Point[] points, Unistroke T, float a, float b, float threshold)
{
  float x1 = Phi * a + (1.0 - Phi) * b;
  float f1 = DistanceAtAngle(points, T, x1);
  float x2 = (1.0 - Phi) * a + Phi * b;
  float f2 = DistanceAtAngle(points, T, x2);
  while (abs (b - a) > threshold)  {
    if (f1 < f2) {
      b = x2;
      x2 = x1;
      f2 = f1;
      x1 = Phi * a + (1.0 - Phi) * b;
      f1 = DistanceAtAngle(points, T, x1);
    } else {
      a = x1;
      x1 = x2;
      f1 = f2;
      x2 = (1.0 - Phi) * a + Phi * b;
      f2 = DistanceAtAngle(points, T, x2);
    }
  }
  return min(f1, f2);
}
float DistanceAtAngle(Point[] points, Unistroke T, float radians) {
  Point[] newpoints = RotateBy(points, radians);
  return PathDistance(newpoints, T.Points);
}
Point Centroid(Point[] points) {
  float x = 0.0, y = 0.0;
  for (int i = 0; i < points.length; i++) {
    x += points[i].X;
    y += points[i].Y;
  }
  x /= points.length;
  y /= points.length;
  return new Point(x, y);
}
Rectangle BoundingBox(Point[] points) {
  float minX = 999999, maxX = -999999, minY = 999999, maxY = -999999;
  for (int i = 0; i < points.length; i++) {
    minX = min(minX, points[i].X);
    minY = min(minY, points[i].Y);
    maxX = max(maxX, points[i].X);
    maxY = max(maxY, points[i].Y);
  }
  return new Rectangle(minX, minY, maxX - minX, maxY - minY);
}
float PathDistance(Point[] pts1, Point[] pts2) {
  float d = 0.0;
  for (int i = 0; i < pts1.length; i++) // assumes pts1.length == pts2.length
    d += Distance(pts1[i], pts2[i]);
  return d / pts1.length;
}
float PathLength(Point[] points) {
  float d = 0.0;
  for (int i = 1; i < points.length; i++)
    d += Distance(points[i - 1], points[i]);
  return d;
}
float Distance(Point p1, Point p2) {
  float dx = p2.X - p1.X;
  float dy = p2.Y - p1.Y;
  return sqrt(dx * dx + dy * dy);
}

float Deg2Rad(float d) { 
  return (d * PI / 180.0);
}



//
// Point class
//
class Point {
  public float X;
  public float Y;
  public Point(float x, float y) {
    this.X = x;
    this.Y = y;
  }
}

//
// Rectangle class
//
class Rectangle {
  public float X;
  public float Y;
  public float Width;
  public float Height;

  public Rectangle (float x, float y, float width, float height) {
    this.X = x;
    this.Y = y;
    this.Width = width;
    this.Height = height;
  }
}



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
 
/* GAME */


GameLevel level;

class GameLevel {
  int number;
  String name="";
  int startFrame;
  RCurve curve;
  DollarRecognizer recognizer = new DollarRecognizer();  // gesture recognition
  ArrayList<Point> userPath = new ArrayList<Point>();  // this is the container for points the user inputs
  boolean finished;
  int finishedFrame;
  boolean success;
  int successFrame;
  float scoreMin;
  float scoreUser;
  boolean allowUserInput = false;
}

int levelEnd = 2000;




GameLevel createGameLevel(int levelNum) {
  GameLevel newLevel = new GameLevel();
  newLevel.number = levelNum;
  newLevel.startFrame = 0;
  newLevel.success = false;
  newLevel.curve = new RCurve();

  if (levelNum == 0) {                // Level One : Circle
    newLevel.curve.createPoints_fromlist(3.0, new float[][] { {130,170,170,130,270, 90,310,130},
                                                     {310,130,350,170,310,230,270,270},
                                                     {270,270,230,310,130,350, 90,310},
                                                     { 90,310, 50,270, 90,210,130,170} });
    newLevel.scoreMin = 5;  // specific number because it's easier : 20 is hard, 10 is easy
  } else if (levelNum == 1) {         // Level Two : Two Sides (open)
    randomPoints(newLevel, 3, 200, false, radians(20));
    newLevel.scoreMin = 8;
  } else if (levelNum == 2) {         // Level Three : Three Sides
    generateShape(newLevel, 3);
    newLevel.scoreMin = 6;
  } else if (levelNum == 3) {         // Level Four : Four Sides
    generateShape(newLevel, 4);
    newLevel.scoreMin = 8;
  } else if (levelNum == 4) {         // Level Five : Five Sides
    generateShape(newLevel, 5);
    newLevel.scoreMin = 5;
  } else if (levelNum == 5) {         // Level Six : Six Sides
    generateShape(newLevel, 6);
    newLevel.scoreMin = 6;
  } else if (levelNum == 6) {         // Level Seven : Seven Sides
    generateShape(newLevel, 7);
    newLevel.scoreMin = 4;
  } else if (levelNum == 7) {         // Level Eight : Eight Sides
    generateShape(newLevel, 8);
    newLevel.scoreMin = 5;
  } else if (levelNum == 8) {         // Level Nine : Nine Sides
    generateShape(newLevel, 9);
    newLevel.scoreMin = 4;
  } else if (levelNum == 9) {         // Level Ten : Ten Sides
    generateShape(newLevel, 10);
    newLevel.scoreMin = 2;
  }
  newLevel.recognizer.addGesture_floats(newLevel.name, newLevel.curve.points);
  return newLevel;
}




void randomPoints(GameLevel level, int numPoints, int minDistance, boolean doesConnect, float minAngle) {
  float firstX = 0;  // stores the first generated point to connect back at the end
  float firstY = 0;  // these need to be equal to zero otherwise it breaks
  float lastX = MAX_FLOAT;  // MAX_FLOAT = largest number a float can handle
  float lastY = MAX_FLOAT;
  float lastAngle = MAX_FLOAT;
  level.curve.beginLines(3.0);
  for (int i = 0; i < numPoints; i++) {
    float x = random(40, 360);
    float y = random(80, 360);
    float newAngle = abs(atan2(y-lastY, x-lastX));  // atan2 calculates angle
    debugprint(newAngle);
    debugprint(lastAngle);
    while (dist(x, y, lastX, lastY) < minDistance || abs(lastAngle - newAngle) < minAngle) {  // this is to make sure the lines are long enough .. use while (instead of if) so that it continuously runs until it finds the right point .. abs = absolute value    
      x = random(40, 360);
      y = random(80, 360);
      newAngle = abs(atan2(y-lastY, x-lastX));
    }
    if (i == 0) {
      firstX = x;
      firstY = y;
    }
    lastAngle = abs(atan2(lastY-y, lastX-x));
    lastX = x;  // update to most recent value so it can calculate the *next* point
    lastY = y;
    level.curve.addPoint(x, y);
  }
  if (doesConnect == true) {
    level.curve.addPoint(firstX, firstY);
  }
  level.curve.endLines();
}




void drawGameScreen() {
  drawStatusDots(255);
  if (millis() - level.startFrame < 2500) {
    float startPathGame = ((millis() - level.startFrame))/1600.0;
    level.curve.drawCurve(startPathGame, 0.4, shapeDefault, pathStrokeWeight);
    level.allowUserInput = false;
  } else {
    level.allowUserInput = true;
    if (level.userPath.size() >= 1) {  // wrapping the following info in an if statement makes the user input go away on the next round on Android
      noFill();
      stroke(userInput);
      strokeWeight(pathStrokeWeight);
      strokeJoin(ROUND);
      beginShape();
        for (int i = 0; i < level.userPath.size(); i++) {
          vertex(level.userPath.get(i).X, level.userPath.get(i).Y);  // array = userPath[i].x but this uses X also an array list = userPath.get(i).X
        }
      endShape();
    }
  }
  if (level.finished == true) {
    level.curve.drawCurve(1, 2, shapeDefault, pathStrokeWeight);
    level.allowUserInput = false;
  }
  if (level.finished == true && level.success == true && (millis() - level.finishedFrame) >= levelEnd) {
    goToLevel(level.number+1);  // go to NEXT level (+1)
  }
  if (level.finished == true && level.success == false && (millis() - level.finishedFrame) >= levelEnd) {
    restartLevel();  // restart level
  }
}




void drawStatusDots(float opacity) {
  for (int i = 0; i < 10; i++) {
    if (level.number == i && level.success == false) {
      strokeWeight(1);
      stroke(statusActive, opacity);
      fill(statusDefault, opacity);
    } else if (level.number >= i) {
      noStroke();
      fill(statusComplete, opacity);
    } else {
      noStroke();
      fill(statusDefault, opacity);
    }
    ellipse(51+(i*33), 40, 20, 20);
  }
}
/* INTRO */


PImage img_great;
PImage img_tryagain;
RCurve introCurve;
int introFrameCount;

DollarRecognizer introDOR = new DollarRecognizer();  // gesture recognition
ArrayList<Point> userPath = new ArrayList<Point>();  // this is the container for points the user inputs

boolean allowUserInput = false;

boolean introFinished;
int introFinishedFrame;
boolean introSuccess = false;
int introSuccessFrame;
int introEnd = 2000;


void drawIntroScreen() {
  textAlign(CENTER);
  fill(#009999);
  textFont(roboto_italic, 20);
  text("trace the shape", 200, 45);  
  if (millis() - introFrameCount < 2500) {
    float startPathIntro = ((millis() - introFrameCount))/1600.0;
    introCurve.drawCurve(startPathIntro, 0.4, shapeDefault, pathStrokeWeight);
  } else if (introFinished == false && introSuccess == false) { // this is between when the game draws the shape and the confirmation // where the user can make their input
    allowUserInput = true;  // enable user input now
    if (userPath.size() >= 1) {  // wrapping the following info in an if statement makes the user input go away on the next round on Android
      noFill();
      stroke(userInput);
      strokeWeight(pathStrokeWeight);
      strokeJoin(ROUND);
      beginShape();
        for (int i = 0; i < userPath.size(); i++) {
          vertex(userPath.get(i).X, userPath.get(i).Y);  // array = userPath[i].x but this uses X also an array list = userPath.get(i).X
        }
      endShape();
    }
  } else {
    allowUserInput = false;  // disable user input again so user can't draw on confirmation screens
  }
  if (introFinished == true && introSuccess == false) {
    tint(255);
    image(img_tryagain, 0, 0, 400, 400);
  }
  if (introFinished == true && introSuccess == false && (millis() - introFinishedFrame) >= introEnd) {
    restartIntro();
  }
  if (introSuccess == true) {
    tint(255);
    image(img_great, 0, 0, 400, 400);
  }
  if (introSuccess == true && (millis() - introSuccessFrame) >= introEnd) {
    goToStateGame();
  }
}



/************************************************************************************/
/*************************************MAGIC HERE*************************************/
/************************************************************************************/
/************************************************************************************/
class RCurve {
  float[] points;
  
  ArrayList<Point> pointList = new ArrayList<Point>();
  float stepsize;
  
  void beginLines(float stepsize) {
     pointList.clear();
     this.stepsize = stepsize;
  }
  void addPoint(float x, float y) {
    pointList.add(new Point(x,y));
  }
  void endLines() {
    float[][] curves = new float[pointList.size()-1][];
    float lastx = pointList.get(0).X;
    float lasty = pointList.get(0).Y;
    for (int i=1; i<pointList.size(); i++) {
      float x = pointList.get(i).X;
      float y = pointList.get(i).Y;
      curves[i-1] = new float[] {lastx,lasty,lastx,lasty,x,y,x,y};
      lastx = x;
      lasty = y;
    }
    createPoints_fromlist(stepsize, curves);
  }
  
  
  void createPoints_manual(float stepsize, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4 ) {
    points = createRCurvePoints(stepsize, new float[][] { {x1,y1,x2,y2,x3,y3,x4,y4}});
  }
  void createPoints_fromlist(float stepsize, float[][] beziercurves ) {
    debugprint("debugprint points");
    points = createRCurvePoints(stepsize, beziercurves);
  }
  
  /**
  beziercurves are a list of curves, with each in the format
  {x1, y1, x2, y2, x3, y3, x4, y4}
  
  example:
  float[] pointlist = createRCurvePoints(1.0, {
    {60,60,600,60,60,600,600,600},
    {600,600,800,600,500,40,600,100}});
  which has two bezier curves.
  **/
  float[] createRCurvePoints(float stepsize, float[][] beziercurves) {
    ArrayList<Float> points = new ArrayList();
    
    for (int curvenum=0; curvenum<beziercurves.length; curvenum++) {
      float x1=beziercurves[curvenum][0];
      float y1=beziercurves[curvenum][1];
      float x2=beziercurves[curvenum][2];
      float y2=beziercurves[curvenum][3];
      float x3=beziercurves[curvenum][4];
      float y3=beziercurves[curvenum][5];
      float x4=beziercurves[curvenum][6];
      float y4=beziercurves[curvenum][7];
      
      float lastbest = 0, x=0, y=0, lastx=0, lasty=0;
      while (lastbest <= 1f) {
        while (dist(x,y,lastx,lasty) < stepsize) {
          lastbest += 0.0001f;
          //x = bezierPoint(60,600,60,600,lastbest);
          //y = bezierPoint(60,60,600,600,lastbest);
          x = bezierPoint(x1,x2,x3,x4,lastbest);
          y = bezierPoint(y1,y2,y3,y4,lastbest);
        }
        lastx = x;
        lasty = y;
        points.add(x);
        points.add(y);
        //debugprint("adding point at "+x+", "+y);
      }
    }
    
    float[] pointlist = new float[points.size()];
    for (int i=0; i<points.size(); i++) {
      pointlist[i] = (points.get(i));
      //debugprint("adding "+pointlist[i]);
    }
    return pointlist;
    
  }
  
  
  /**
  points = points made with setupPointlist
  startpath = a value from 0 to 1 representing where to start drawing
  pathlength = a value from 0 to 1 representing how much of the path to draw
  **/
  void drawCurve(float startpath, float pathlength, color pathcolor, float radius) {
    pushStyle();
    float[] pointlist = points;
    float endpath = startpath - pathlength;
    startpath = constrain(startpath, 0, 1);
    endpath = constrain(endpath, 0, 1);
    //float actuallength = startpath - endpath;
    
    noStroke();
    int startindex = int((pointlist.length/2)*startpath)*2;
    int endindex = int((pointlist.length/2)*endpath)*2;
    int numPointsBetween = int((pointlist.length/2)*pathlength)*2;
    int fadeness = 50;
    for (int i=endindex; i<startindex; i+=2) {
      float x = pointlist[i];
      float y = pointlist[i+1];
      float opacity = abs(float(i-startindex)/numPointsBetween);
      fill(pathcolor,fadeness-fadeness*opacity);
      ellipse(x,y,radius,radius);
    }
    popStyle();
  }
}

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


void generateShape(GameLevel level, int numSides) {
  if (numSides == 3) {
    Shape levelShape = chooseShape3();
    insertPoints(level, levelShape);
  } else if (numSides == 4) {
    Shape levelShape = chooseShape4();
    insertPoints(level, levelShape);
  } else if (numSides == 5) {
    Shape levelShape = chooseShape5();
    insertPoints(level, levelShape);
  } else if (numSides == 6) {
    Shape levelShape = chooseShape6();
    insertPoints(level, levelShape);
  } else if (numSides == 7) {
    Shape levelShape = chooseShape7();
    insertPoints(level, levelShape);
  } else if (numSides == 8) {
    Shape levelShape = chooseShape8();
    insertPoints(level, levelShape);
  } else if (numSides == 9) {
    Shape levelShape = chooseShape9();
    insertPoints(level, levelShape);
  } else if (numSides == 10) {
    Shape levelShape = chooseShape10();
    insertPoints(level, levelShape);
  }
}


void insertPoints(GameLevel level, Shape levelShape) {
  level.curve.beginLines(3.0);
  for (int i = 0; i < levelShape.points.length; i ++) {
    float x = levelShape.points[i][0];
    float y = levelShape.points[i][1];
    level.curve.addPoint(x, y);
  }
  level.curve.endLines();
}

class Shape {
  float[][] points;
}




/* SHAPE WITH THREE SIDES */

Shape chooseShape3() {
  int i = int(random(0, allShapesForLevel3.length));
  return allShapesForLevel3[i];
}

Shape[] allShapesForLevel3 = { generateShape3A(), generateShape3B(), generateShape3C(), generateShape3D() };

Shape generateShape3A() {
  Shape s3A = new Shape();
  s3A.points = new float[][] { {80, 120}, {320, 120}, {200, 320}, {80, 120} };  // syntax is fucked up
  return s3A;
}

Shape generateShape3B() {
  Shape s3B = new Shape();
  s3B.points = new float[][] { {340, 340}, {340, 100}, {60, 100}, {340, 340} };
  return s3B;
}

Shape generateShape3C() {
  Shape s3C = new Shape();
  s3C.points = new float[][] { {340, 220}, {60, 340}, {60, 100}, {340, 220} };
  return s3C;
}

Shape generateShape3D() {
  Shape s3D = new Shape();
  s3D.points = new float[][] { {80, 120}, {160, 280}, {320, 280}, {80, 120} };
  return s3D;
}




/* SHAPE WITH FOUR SIDES */

Shape chooseShape4() {
  int i = int(random(0, allShapesForLevel4.length));
  return allShapesForLevel4[i];
}

Shape[] allShapesForLevel4 = { generateShape4A(), generateShape4B(), generateShape4C(), generateShape4D(), generateShape4E(), generateShape4F(), generateShape4G(), generateShape4H(), generateShape4I() };

Shape generateShape4A() {
  Shape s4A = new Shape();
  s4A.points = new float[][] { {80, 320}, {80, 120}, {320, 120}, {320, 320}, {80, 320} };
  return s4A;
}

Shape generateShape4B() {
  Shape s4B = new Shape();
  s4B.points = new float[][] { {280, 340}, {280, 100}, {120, 100}, {120, 340}, {280, 340} };
  return s4B;
}

Shape generateShape4C() {
  Shape s4C = new Shape();
  s4C.points = new float[][] { {200, 200}, {60, 100}, {200, 340}, {340, 100}, {200, 200} };
  return s4C;
}

Shape generateShape4D() {
  Shape s4D = new Shape();
  s4D.points = new float[][] { {200, 320}, {80, 320}, {80, 120}, {320, 120}, {200, 320} };
  return s4D;
}

Shape generateShape4E() {
  Shape s4E = new Shape();
  s4E.points = new float[][] { {320, 120}, {160, 120}, {80, 320}, {240, 320}, {320, 120} };
  return s4E;
}

Shape generateShape4F() {
  Shape s4F = new Shape();
  s4F.points = new float[][] { {320, 320}, {80, 280}, {80, 120}, {320, 160}, {320, 320} };
  return s4F;
}

Shape generateShape4G() {
  Shape s4G = new Shape();
  s4G.points = new float[][] { {200, 100}, {80, 220}, {200, 340}, {320, 220}, {200, 100} };
  return s4G;
}

Shape generateShape4H() {
  Shape s4H = new Shape();
  s4H.points = new float[][] { {140, 340}, {260, 340}, {340, 100}, {60, 100}, {140, 340} };
  return s4H;
}

Shape generateShape4I() {
  Shape s4I = new Shape();
  s4I.points = new float[][] { {200, 120}, {320, 320}, {80, 320}, {80, 120}, {200, 120} };
  return s4I;
}




/* SHAPE WITH FIVE SIDES */

Shape chooseShape5() {
  int i = int(random(0, allShapesForLevel5.length));
  return allShapesForLevel5[i];
}

Shape[] allShapesForLevel5 = { generateShape5A(), generateShape5B(), generateShape5C(), generateShape5D(), generateShape5E(), generateShape5F(), generateShape5G(), generateShape5H() };

Shape generateShape5A() {
  Shape s5A = new Shape();
  s5A.points = new float[][] { {310, 220}, {230, 100}, {100, 140}, {90, 270}, {220, 330}, {310, 220} };
  return s5A;
}

Shape generateShape5B() {
  Shape s5B = new Shape();
  s5B.points = new float[][] { {80, 120}, {320, 120}, {320, 320}, {200, 230}, {80, 320}, {80, 120} };
  return s5B;
}

Shape generateShape5C() {
  Shape s5C = new Shape();
  s5C.points = new float[][] { {70, 120}, {250, 340}, {330, 200}, {290, 120}, {210, 160}, {70, 120} };
  return s5C;
}

Shape generateShape5D() {
  Shape s5D = new Shape();
  s5D.points = new float[][] { {80, 320}, {80, 240}, {200, 120}, {320, 240}, {320, 320}, {80, 320} };
  return s5D;
}

Shape generateShape5E() {
  Shape s5E = new Shape();
  s5E.points = new float[][] { {320, 160}, {260, 100}, {140, 100}, {80, 160}, {200, 340}, {320, 160} };
  return s5E;
}

Shape generateShape5F() {
  Shape s5F = new Shape();
  s5F.points = new float[][] { {60, 100}, {200, 260}, {340, 100}, {280, 340}, {120, 340}, {60, 100} };
  return s5F;
}

Shape generateShape5G() {
  Shape s5G = new Shape();
  s5G.points = new float[][] { {220, 220}, {320, 160}, {120, 120}, {80, 200}, {200, 320}, {220, 220} };
  return s5G;
}

Shape generateShape5H() {
  Shape s5H = new Shape();
  s5H.points = new float[][] { {100, 210}, {190, 120}, {300, 120}, {300, 320}, {100, 320}, {100, 210} };
  return s5H;
}




/* SHAPE WITH SIX SIDES */

Shape chooseShape6() {
  int i = int(random(0, allShapesForLevel6.length));
  return allShapesForLevel6[i];
}

Shape[] allShapesForLevel6 = { generateShape6A(), generateShape6B(), generateShape6C(), generateShape6D(), generateShape6E(), generateShape6F(), generateShape6G(), generateShape6H(), generateShape6I(), generateShape6J(), generateShape6K(), generateShape6L() };

Shape generateShape6A() {
  Shape s6A = new Shape();
  s6A.points = new float[][] { {80, 320}, {80, 240}, {200, 120}, {240, 200}, {320, 240}, {320, 320}, {80, 320} };
  return s6A;
}

Shape generateShape6B() {
  Shape s6B = new Shape();
  s6B.points = new float[][] { {200, 190}, {320, 120}, {320, 320}, {200, 250}, {80, 320}, {80, 120}, {200, 190} };
  return s6B;
}

Shape generateShape6C() {
  Shape s6C = new Shape();
  s6C.points = new float[][] { {80, 260}, {80, 120}, {200, 180}, {320, 120}, {320, 260}, {200, 320}, {80, 260} };
  return s6C;
}

Shape generateShape6D() {
  Shape s6D = new Shape();
  s6D.points = new float[][] { {310, 220}, {260, 120}, {140, 120}, {90, 220}, {140, 320}, {260, 320}, {310, 220} };
  return s6D;
}

Shape generateShape6E() {
  Shape s6E = new Shape();
  s6E.points = new float[][] { {160, 220}, {160, 320}, {320, 320}, {240, 220}, {240, 120}, {80, 120}, {160, 220} };
  return s6E;
}

Shape generateShape6F() {
  Shape s6F = new Shape();
  s6F.points = new float[][] { {260, 200}, {300, 310}, {180, 280}, {70, 330}, {200, 100}, {320, 160}, {260, 200} };
  return s6F;
}

Shape generateShape6G() {
  Shape s6G = new Shape();
  s6G.points = new float[][] { {160, 100}, {80, 260}, {140, 340}, {260, 340}, {320, 260}, {240, 100}, {160, 100} };
  return s6G;
}

Shape generateShape6H() {
  Shape s6H = new Shape();
  s6H.points = new float[][] { {200, 340}, {70, 220}, {120, 110}, {200, 190}, {280, 110}, {330, 220}, {200, 340} };
  return s6H;
}

Shape generateShape6I() {
  Shape s6I = new Shape();
  s6I.points = new float[][] { {200, 220}, {300, 220}, {300, 120}, {100, 120}, {100, 320}, {300, 320}, {200, 220} };
  return s6I;
}

Shape generateShape6J() {
  Shape s6J = new Shape();
  s6J.points = new float[][] { {90, 120}, {310, 120}, {210, 200}, {290, 320}, {170, 240}, {90, 340}, {90, 120} };
  return s6J;
}

Shape generateShape6K() {
  Shape s6K = new Shape();
  s6K.points = new float[][] { {320, 260}, {260, 320}, {80, 320}, {80, 180}, {140, 120}, {320, 120}, {320, 260} };
  return s6K;
}

Shape generateShape6L() {
  Shape s6L = new Shape();
  s6L.points = new float[][] { {320, 280}, {320, 160}, {240, 120}, {80, 120}, {80, 320}, {240, 320}, {320, 280} };
  return s6L;
}




/* SHAPE WITH SEVEN SIDES */

Shape chooseShape7() {
  int i = int(random(0, allShapesForLevel7.length));
  return allShapesForLevel7[i];
}

Shape[] allShapesForLevel7 = { generateShape7A(), generateShape7B(), generateShape7C(), generateShape7D(), generateShape7E(), generateShape7F(), generateShape7G(), generateShape7H(), generateShape7I(), generateShape7J(), generateShape7K(), generateShape7L(), generateShape7M() };

Shape generateShape7A() {
  Shape s7A = new Shape();
  s7A.points = new float[][] { {250, 110}, {70, 110}, {70, 330}, {160, 250}, {160, 330}, {300, 180}, {160, 180}, {250, 110}  };
  return s7A;
}

Shape generateShape7B() {
  Shape s7B = new Shape();
  s7B.points = new float[][] { {70, 110}, {70, 330}, {160, 250}, {160, 330}, {330, 330}, {330, 170}, {250, 110}, {70, 110} };
  return s7B;
}

Shape generateShape7C() {
  Shape s7C = new Shape();
  s7C.points = new float[][] { {200, 160}, {270, 320}, {320, 320}, {320, 120}, {80, 120}, {80, 320}, {130, 320}, {200, 160} };
  return s7C;
}

Shape generateShape7D() {
  Shape s7D = new Shape();
  s7D.points = new float[][] { {250, 120}, {80, 320}, {140, 320}, {270, 170}, {270, 320}, {320, 320}, {320, 120}, {250, 120} };
  return s7D;
}

Shape generateShape7E() {
  Shape s7E = new Shape();
  s7E.points = new float[][] { {320, 120}, {290, 270}, {180, 320}, {80, 250}, {160, 200}, {80, 120}, {210, 160}, {320, 120}  };
  return s7E;
}

Shape generateShape7F() {
  Shape s7F = new Shape();
  s7F.points = new float[][] { {220, 220}, {320, 220}, {320, 320}, {180, 320}, {120, 260}, {120, 120}, {220, 120}, {220, 220} };
  return s7F;
}

Shape generateShape7G() {
  Shape s7G = new Shape();
  s7G.points = new float[][] { {310, 150}, {330, 250}, {260, 340}, {140, 340}, {70, 250}, {90, 150}, {200, 100}, {310, 150} };
  return s7G;
}

Shape generateShape7H() {
  Shape s7H = new Shape();
  s7H.points = new float[][] { {320, 170}, {270, 270}, {320, 320}, {80, 320}, {130, 170}, {80, 120}, {270, 120}, {320, 170} };
  return s7H;
}

Shape generateShape7I() {
  Shape s7I = new Shape();
  s7I.points = new float[][] { {160, 250}, {160, 320}, {70, 220}, {150, 110}, {330, 180}, {320, 330}, {230, 210}, {160, 250}  };
  return s7I;
}

Shape generateShape7J() {
  Shape s7J = new Shape();
  s7J.points = new float[][] { {80, 330}, {230, 330}, {170, 280}, {300, 140}, {270, 110}, {130, 250}, {80, 190}, {80, 330} };
  return s7J;
}

Shape generateShape7K() {
  Shape s7K = new Shape();
  s7K.points = new float[][] { {80, 330}, {230, 330}, {170, 280}, {320, 210}, {270, 110}, {80, 120}, {130, 180}, {80, 330} };
  return s7K;
}

Shape generateShape7L() {
  Shape s7L = new Shape();
  s7L.points = new float[][] { {200, 270}, {240, 180}, {200, 80}, {120, 270}, {160, 360}, {280, 360}, {280, 270}, {200, 270} };
  return s7L;
}

Shape generateShape7M() {
  Shape s7M = new Shape();
  s7M.points = new float[][] { {330, 190}, {210, 190}, {160, 90}, {90, 230}, {180, 350}, {320, 350}, {240, 280}, {330, 190} };
  return s7M;
}




/* SHAPE WITH EIGHT SIDES */

Shape chooseShape8() {
  int i = int(random(0, allShapesForLevel8.length));
  return allShapesForLevel8[i];
}

Shape[] allShapesForLevel8 = { generateShape8A(), generateShape8B(), generateShape8C(), generateShape8D(), generateShape8E(), generateShape8F(), generateShape8G(), generateShape8H() };

Shape generateShape8A() {
  Shape s8A = new Shape();
  s8A.points = new float[][] { {240, 190}, {300, 360}, {100, 360}, {220, 320}, {180, 210}, {110, 240}, {190, 80}, {320, 160}, {240, 190} };
  return s8A;
}

Shape generateShape8B() {
  Shape s8B = new Shape();
  s8B.points = new float[][] { {250, 250}, {320, 250}, {320, 120}, {150, 120}, {150, 190}, {80, 190}, {80, 320}, {250, 320}, {250, 250}  };
  return s8B;
}

Shape generateShape8C() {
  Shape s8C = new Shape();
  s8C.points = new float[][] { {120, 250}, {320, 250}, {320, 120}, {150, 120}, {280, 190}, {80, 190}, {80, 320}, {250, 320}, {120, 250} };
  return s8C;
}

Shape generateShape8D() {
  Shape s8D = new Shape();
  s8D.points = new float[][] { {220, 200}, {80, 200}, {180, 320}, {250, 320}, {180, 240}, {320, 240}, {220, 120}, {150, 120}, {220, 200} };
  return s8D;
}

Shape generateShape8E() {
  Shape s8E = new Shape();
  s8E.points = new float[][] { {240, 310}, {240, 220}, {320, 220}, {320, 130}, {80, 130}, {80, 220}, {160, 220}, {160, 310}, {240, 310} };
  return s8E;
}

Shape generateShape8F() {
  Shape s8F = new Shape();
  s8F.points = new float[][] { {320, 320}, {280, 220}, {320, 120}, {200, 170}, {80, 120}, {130, 220}, {80, 320}, {200, 270}, {320, 320} };
  return s8F;
}

Shape generateShape8G() {
  Shape s8G = new Shape();
  s8G.points = new float[][] { {200, 120}, {170, 190}, {80, 220}, {170, 250}, {200, 320}, {230, 250}, {320, 220}, {230, 190}, {200, 120} };
  return s8G;
}

Shape generateShape8H() {
  Shape s8H = new Shape();
  s8H.points = new float[][] { {130, 150}, {100, 220}, {130, 290}, {200, 320}, {270, 290}, {300, 220}, {270, 150}, {200, 120}, {130, 150} };
  return s8H;
}




/* SHAPE WITH NINE SIDES */

Shape chooseShape9() {
  int i = int(random(0, allShapesForLevel9.length));
  return allShapesForLevel9[i];
}

Shape[] allShapesForLevel9 = { generateShape9A(), generateShape9B(), generateShape9C(), generateShape9D(), generateShape9E(), generateShape9F(), generateShape9G() };

Shape generateShape9A() {
  Shape s9A = new Shape();
  s9A.points = new float[][] { {150, 190}, {80, 190}, {80, 260}, {150, 260}, {150, 330}, {220, 330}, {220, 260}, {290, 260}, {150, 120}, {150, 190} };
  return s9A;
}

Shape generateShape9B() {
  Shape s9B = new Shape();
  s9B.points = new float[][] { {220, 180}, {80, 120}, {120, 220}, {80, 320}, {220, 260}, {220, 320}, {320, 320}, {320, 120}, {220, 120}, {220, 180} };
  return s9B;
}

Shape generateShape9C() {
  Shape s9C = new Shape();
  s9C.points = new float[][] { {80, 200}, {80, 320}, {180, 320}, {180, 270}, {230, 270}, {230, 320}, {320, 320}, {320, 200}, {200, 120}, {80, 200} };
  return s9C;
}

Shape generateShape9D() {
  Shape s9D = new Shape();
  s9D.points = new float[][] { {190, 170}, {180, 240}, {260, 270}, {290, 330}, {310, 250}, {250, 220}, {260, 150}, {180, 110}, {70, 110}, {190, 170} };
  return s9D;
}

Shape generateShape9E() {
  Shape s9E = new Shape();
  s9E.points = new float[][] { {80, 250}, {80, 190}, {140, 190}, {140, 120}, {230, 120}, {320, 220}, {230, 320}, {140, 320}, {140, 250}, {80, 250} };
  return s9E;
}

Shape generateShape9F() {
  Shape s9F = new Shape();
  s9F.points = new float[][] { {230, 120}, {230, 190}, {320, 220}, {320, 320}, {230, 320}, {180, 250}, {80, 320}, {80, 120}, {130, 190}, {230, 120} };
  return s9F;
}

Shape generateShape9G() {
  Shape s9G = new Shape();
  s9G.points = new float[][] { {250, 320}, {150, 290}, {170, 230}, {90, 210}, {110, 140}, {200, 120}, {280, 160}, {240, 210}, {320, 250}, {250, 320}  };
  return s9G;
}




/* SHAPE WITH TEN SIDES */

Shape chooseShape10() {
  int i = int(random(0, allShapesForLevel10.length));
  return allShapesForLevel10[i];
}

Shape[] allShapesForLevel10 = { generateShape10A(), generateShape10B(), generateShape10C(), generateShape10D(), generateShape10E(), generateShape10F(), generateShape10G(), generateShape10H() };

Shape generateShape10A() {
  Shape s10A = new Shape();
  s10A.points = new float[][] { {290, 170}, {240, 120}, {110, 120}, {160, 170}, {110, 220}, {160, 270}, {110, 320}, {240, 320}, {290, 270}, {240, 220}, {290, 170} };
  return s10A;
}

Shape generateShape10B() {
  Shape s10B = new Shape();
  s10B.points = new float[][] { {300, 250}, {300, 110}, {230, 110}, {230, 180}, {160, 180}, {160, 250}, {90, 250}, {90, 320}, {230, 320}, {230, 250}, {300, 250} };
  return s10B;
}

Shape generateShape10C() {
  Shape s10C = new Shape();
  s10C.points = new float[][] { {160, 180}, {260, 180}, {260, 230}, {210, 230}, {210, 320}, {320, 320}, {320, 120}, {80, 120}, {80, 320}, {160, 320}, {160, 180} };
  return s10C;
}

Shape generateShape10D() {
  Shape s10D = new Shape();
  s10D.points = new float[][] { {200, 320}, {260, 250}, {320, 320}, {320, 120}, {260, 190}, {200, 120}, {140, 190}, {80, 120}, {80, 320}, {140, 250}, {200, 320} };
  return s10D;
}

Shape generateShape10E() {
  Shape s10E = new Shape();
  s10E.points = new float[][] { {320, 320}, {320, 210}, {270, 210}, {230, 170}, {230, 120}, {80, 120}, {80, 230}, {130, 230}, {170, 270}, {170, 320}, {320, 320} };
  return s10E;
}

Shape generateShape10F() {
  Shape s10F = new Shape();
  s10F.points = new float[][] { {250, 320}, {320, 250}, {320, 190}, {250, 190}, {250, 120}, {150, 120}, {80, 190}, {80, 250}, {150, 250}, {150, 320}, {250, 320} };
  return s10F;
}

Shape generateShape10G() {
  Shape s10G = new Shape();
  s10G.points = new float[][] { {200, 120}, {200, 160}, {340, 100}, {280, 200}, {320, 240}, {240, 260}, {320, 360}, {160, 360}, {80, 240}, {80, 90}, {200, 120}  };
  return s10G;
}

Shape generateShape10H() {
  Shape s10H = new Shape();
  s10H.points = new float[][] { {260, 250}, {330, 180}, {240, 170}, {200, 90}, {160, 170}, {70, 180}, {140, 250}, {100, 350}, {200, 310}, {300, 350}, {260, 250}  };
  return s10H;
}

