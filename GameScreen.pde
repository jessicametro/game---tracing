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
    newLevel.curve.createPoints(3.0, new float[][] { {130,170,170,130,270, 90,310,130},
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
