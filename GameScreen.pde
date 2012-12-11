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
}

int levelEnd = 120;


/*
void setupLevel(GameLevel level, RCurve myCurve) {
  level.curve = myCurve;
  level.recognizer.addGesture(name, level.curve.points);
}
*/


GameLevel createGameLevel(int levelNum) {
  GameLevel newLevel = new GameLevel();
  newLevel.number = levelNum;
  newLevel.startFrame = 0;
  newLevel.success = false;
  newLevel.curve = new RCurve();

  if (levelNum == 0) {                 // Level One : Circle
    generateShape(newLevel, 3);
    newLevel.scoreMin = 2;
  } else if (levelNum == 1) {
    generateShape(newLevel, 4);
    newLevel.scoreMin = 2;
  } else if (levelNum == 2) {
    generateShape(newLevel, 5);
    newLevel.scoreMin = 2;
  } else if (levelNum == 3) {
    generateShape(newLevel, 6);
    newLevel.scoreMin = 2;
  
  
  
//    newLevel.curve.createPoints(3.0, new float[][] { {130,170,170,130,270, 90,310,130},
//                                                     {310,130,350,170,310,230,270,270},
//                                                     {270,270,230,310,130,350, 90,310},
//                                                     { 90,310, 50,270, 90,210,130,170} });
//    newLevel.scoreMin = 12;  // specific number because it's easier : 20 is hard, 10 is easy
//  } else if (levelNum == 1) {         // Level Two : Two Sides (open)
//    newLevel.curve.beginLines(3.0);
//    newLevel.curve.addPoint(120,110);
//    newLevel.curve.addPoint(320,310);
//    newLevel.curve.addPoint(80,270);
//    newLevel.curve.endLines();
//    randomPoints(newLevel, 3, 200);
//    newLevel.scoreMin = 10;
//  } else if (levelNum == 2) {         // Level Three : Three Sides (connected)
//    newLevel.curve.beginLines(3.0);
//    newLevel.curve.addPoint(290,120);
//    newLevel.curve.addPoint(90,140);
//    newLevel.curve.addPoint(140,340);
//    newLevel.curve.addPoint(290,120);
//    randomPoints(newLevel, 3, 150, true);
//    newLevel.curve.endLines();
//    newLevel.scoreMin = 12;
//  } else if (levelNum == 3) {         // Level Four : Four Sides (connected)
//    newLevel.curve.beginLines(3.0);
//    newLevel.curve.addPoint(60,310);
//    newLevel.curve.addPoint(300,310);
//    newLevel.curve.addPoint(340,190);
//    newLevel.curve.addPoint(100,110);
//    newLevel.curve.addPoint(60,310);
//    newLevel.curve.endLines();
    //randomPoints(newLevel, 6, 150, true, radians(20));
    
  } else if (levelNum == 4) {         // Level Five : Five Sides (connected)
    newLevel.curve.beginLines(3.0);
    newLevel.curve.addPoint(170,218);
    newLevel.curve.addPoint(210,100);
    newLevel.curve.addPoint(85,100);
    newLevel.curve.addPoint(95,340);
    newLevel.curve.addPoint(330,345);
    newLevel.curve.addPoint(170,218);
    newLevel.curve.endLines();
    newLevel.scoreMin = 5;
  } else if (levelNum == 5) {         // Level Six : Six Sides (connected)
    newLevel.curve.beginLines(3.0);
    newLevel.curve.addPoint(180,260);
    newLevel.curve.addPoint(160,330);
    newLevel.curve.addPoint(310,340);
    newLevel.curve.addPoint(220,220);
    newLevel.curve.addPoint(310,100);
    newLevel.curve.addPoint(70,130);
    newLevel.curve.addPoint(180,260);
    newLevel.curve.endLines();
    newLevel.scoreMin = 8;
  } else if (levelNum == 6) {         // Level Seven : Seven Sides (connected)
    newLevel.curve.beginLines(3.0);
    newLevel.curve.addPoint(178,350);
    newLevel.curve.addPoint(94,230);
    newLevel.curve.addPoint(158,90);
    newLevel.curve.addPoint(205,190);
    newLevel.curve.addPoint(335,188);
    newLevel.curve.addPoint(237,280);
    newLevel.curve.addPoint(314,350);
    newLevel.curve.addPoint(178,350);
    newLevel.curve.endLines();
    newLevel.scoreMin = 5;
  } else if (levelNum == 7) {         // Level Eight : Eight Sides (connected..arrow)
    newLevel.curve.beginLines(3.0);
    newLevel.curve.addPoint(244,190);
    newLevel.curve.addPoint(306,363);
    newLevel.curve.addPoint(106,363);
    newLevel.curve.addPoint(222,318);
    newLevel.curve.addPoint(186,208);
    newLevel.curve.addPoint(109,235);
    newLevel.curve.addPoint(186,84);
    newLevel.curve.addPoint(316,164);
    newLevel.curve.addPoint(244,190);
    newLevel.curve.endLines();
    newLevel.scoreMin = 4;
  } else if (levelNum == 8) {         // Level Nine : Nine Sides (connected)
    newLevel.curve.beginLines(3.0);
    newLevel.curve.addPoint(340,360);
    newLevel.curve.addPoint(230,200);
    newLevel.curve.addPoint(340,90);
    newLevel.curve.addPoint(160,160);
    newLevel.curve.addPoint(110,80);
    newLevel.curve.addPoint(100,200);
    newLevel.curve.addPoint(150,240);
    newLevel.curve.addPoint(120,360);
    newLevel.curve.addPoint(240,320);
    newLevel.curve.addPoint(340,360);
    newLevel.curve.endLines();
    newLevel.scoreMin = 3;
  } else if (levelNum == 9) {         // Level Ten : Ten Sides (connected..star)
    newLevel.curve.beginLines(3.0);
    newLevel.curve.addPoint(170,190);
    newLevel.curve.addPoint(70,160);
    newLevel.curve.addPoint(140,250);
    newLevel.curve.addPoint(110,370);
    newLevel.curve.addPoint(200,320);
    newLevel.curve.addPoint(320,340);
    newLevel.curve.addPoint(260,250);
    newLevel.curve.addPoint(330,220);
    newLevel.curve.addPoint(230,180);
    newLevel.curve.addPoint(170,90);
    newLevel.curve.addPoint(170,190);
    newLevel.curve.endLines();
    newLevel.scoreMin = 2;
  }
  newLevel.recognizer.addGesture(newLevel.name, newLevel.curve.points);
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
    println(newAngle);
    println(lastAngle);
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
  if (frameCount - level.startFrame < 150) {
    float startPathGame = ((frameCount - level.startFrame))/100.0;
    level.curve.drawCurve(startPathGame, 0.4, shapeDefault, pathStrokeWeight);
  } 
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
  if (level.finished == true) {
    level.curve.drawCurve(1, 2, shapeDefault, pathStrokeWeight);
  }
  if (level.finished == true && level.success == true && (frameCount - level.finishedFrame) >= levelEnd) {
    goToLevel(level.number+1);  // go to NEXT level (+1)
  }
  if (level.finished == true && level.success == false && (frameCount - level.finishedFrame) >= levelEnd) {
    restartLevel();  // restart level
  }
//  if (level.number == 9 && level.success == true) {
//    image(img_win, 0, 0);
//  }
}



void drawStatusDots(float opacity) {
  
  if (level.number == 0 && level.success == false) {
    strokeWeight(1);
    stroke(statusActive, opacity);
    fill(statusDefault, opacity);
  } else if (level.number >= 0) {
    noStroke();
    fill(statusComplete, opacity);
  } else {
    noStroke();
    fill(statusDefault, opacity);
  }
  ellipse(51, 40, 20, 20);
  
  if (level.number == 1 && level.success == false) {
    strokeWeight(1);
    stroke(statusActive, opacity);
    fill(statusDefault, opacity);
  } else if (level.number >= 1) {
    noStroke();
    fill(statusComplete, opacity);
  } else {
    noStroke();
    fill(statusDefault, opacity);
  }
  ellipse(84, 40, 20, 20);
  
  if (level.number == 2 && level.success == false) {
    strokeWeight(1);
    stroke(statusActive, opacity);
    fill(statusDefault, opacity);
  } else if (level.number >= 2) {
    noStroke();
    fill(statusComplete, opacity);
  } else {
    noStroke();
    fill(statusDefault, opacity);
  }
  ellipse(117, 40, 20, 20);
  
  if (level.number == 3 && level.success == false) {
    strokeWeight(1);
    stroke(statusActive, opacity);
    fill(statusDefault, opacity);
  } else if (level.number >= 3) {
    noStroke();
    fill(statusComplete, opacity);
  } else {
    noStroke();
    fill(statusDefault, opacity);
  }
  ellipse(150, 40, 20, 20);
  
  if (level.number == 4 && level.success == false) {
    strokeWeight(1);
    stroke(statusActive, opacity);
    fill(statusDefault, opacity);
  } else if (level.number >= 4) {
    noStroke();
    fill(statusComplete, opacity);
  } else {
    noStroke();
    fill(statusDefault, opacity);
  }
  ellipse(183, 40, 20, 20);
  
  if (level.number == 5 && level.success == false) {
    strokeWeight(1);
    stroke(statusActive, opacity);
    fill(statusDefault, opacity);
  } else if (level.number >= 5) {
    noStroke();
    fill(statusComplete, opacity);
  } else {
    noStroke();
    fill(statusDefault, opacity);
  }
  ellipse(216, 40, 20, 20);
  
  if (level.number == 6 && level.success == false) {
    strokeWeight(1);
    stroke(statusActive, opacity);
    fill(statusDefault, opacity);
  } else if (level.number >= 6) {
    noStroke();
    fill(statusComplete, opacity);
  } else {
    noStroke();
    fill(statusDefault, opacity);
  }
  ellipse(249, 40, 20, 20);
  
  if (level.number == 7 && level.success == false) {
    strokeWeight(1);
    stroke(statusActive, opacity);
    fill(statusDefault, opacity);
  } else if (level.number >= 7) {
    noStroke();
    fill(statusComplete, opacity);
  } else {
    noStroke();
    fill(statusDefault, opacity);
  }
  ellipse(282, 40, 20, 20);
  
  if (level.number == 8 && level.success == false) {
    strokeWeight(1);
    stroke(statusActive, opacity);
    fill(statusDefault, opacity);
  } else if (level.number >= 8) {
    noStroke();
    fill(statusComplete, opacity);
  } else {
    noStroke();
    fill(statusDefault, opacity);
  }
  ellipse(315, 40, 20, 20);
  
  if (level.number == 9 && level.success == false) {
    strokeWeight(1);
    stroke(statusActive, opacity);
    fill(statusDefault, opacity);
  } else if (level.number >= 9) {
    noStroke();
    fill(statusComplete, opacity);
  } else {
    noStroke();
    fill(statusDefault, opacity);
  }
  ellipse(348, 40, 20, 20);
}
