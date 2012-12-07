/* GAME */


GameLevel level;

class GameLevel {
  int number;
  String name="";
  int startFrame;
  RCurve curve;
  DollarRecognizer recognizer = new DollarRecognizer();  // gesture recognition
  ArrayList<Point> userPath = new ArrayList<Point>();  // this is the container for points the user inputs
  boolean success;
  int successFrame;
  float scoreMin;
  float scoreUser;
}

int levelEnd = 120;

PImage img_win;


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
    newLevel.curve.beginLines(3.0);
    newLevel.curve.addPoint(40,90);
    newLevel.curve.addPoint(90,90);
    newLevel.curve.addPoint(340,360);
    newLevel.curve.endLines();
    newLevel.scoreMin = scoreMin;
  } else if (levelNum == 1) {         // Level Two : Two Sides (open)
    newLevel.curve.beginLines(3.0);
    newLevel.curve.addPoint(120,110);
    newLevel.curve.addPoint(320,310);
    newLevel.curve.addPoint(80,270);
    newLevel.curve.endLines();
    newLevel.scoreMin = scoreMin;
  } else if (levelNum == 2) {         // Level Three : Three Sides (connected)
    newLevel.curve.beginLines(3.0);
    newLevel.curve.addPoint(290,120);
    newLevel.curve.addPoint(90,140);
    newLevel.curve.addPoint(140,340);
    newLevel.curve.addPoint(290,120);
    newLevel.curve.endLines();
    newLevel.scoreMin = scoreMin;
  } else if (levelNum == 3) {         // Level Four : Four Sides (connected)
    newLevel.curve.beginLines(3.0);
    newLevel.curve.addPoint(60,310);
    newLevel.curve.addPoint(300,310);
    newLevel.curve.addPoint(340,190);
    newLevel.curve.addPoint(100,110);
    newLevel.curve.addPoint(60,310);
    newLevel.curve.endLines();
    newLevel.scoreMin = scoreMin;
  } else if (levelNum == 4) {         // Level Five : Five Sides (connected)
    newLevel.curve.beginLines(3.0);
    newLevel.curve.addPoint(170,218);
    newLevel.curve.addPoint(210,100);
    newLevel.curve.addPoint(85,100);
    newLevel.curve.addPoint(95,340);
    newLevel.curve.addPoint(330,345);
    newLevel.curve.addPoint(170,218);
    newLevel.curve.endLines();
    newLevel.scoreMin = scoreMin;
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
    newLevel.scoreMin = scoreMin;
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
    newLevel.scoreMin = scoreMin;
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
    newLevel.scoreMin = scoreMin;
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
    newLevel.scoreMin = scoreMin;
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
    newLevel.scoreMin = scoreMin;
  }
  newLevel.recognizer.addGesture(newLevel.name, newLevel.curve.points);
  return newLevel;
}



void drawGameScreen() {
  drawStatusDots();
  if (frameCount - level.startFrame < 150) {
    float startPathGame = ((frameCount - level.startFrame))/100.0;
    level.curve.drawCurve(startPathGame, 0.4, shapeDefault, pathStrokeWeight);
  } 
  noFill();
  stroke(userInput);
  strokeWeight(pathStrokeWeight);
  strokeJoin(ROUND);
  beginShape();
    for (int i = 0; i < level.userPath.size(); i++) {
      vertex(level.userPath.get(i).X, level.userPath.get(i).Y);  // array = userPath[i].x but this uses X also an array list = userPath.get(i).X
    }
  endShape();
  if (level.success == true) {
    image(img_great, 0, 0);  // DON'T FORGET TO CHANGE THIS TO THE ORIGININAL SHAPE
    tint(255);
  }
  if (level.success == true && (frameCount - level.successFrame) >= levelEnd) {
    goToLevel(level.number+1);  // go to NEXT level (+1)
  }
//  if (level.number == 9 && level.success == true) {
//    image(img_win, 0, 0);
//  }
}



void drawStatusDots() {

  if (level.number == 0) {
    strokeWeight(1);
    stroke(statusActive);
    fill(statusDefault);
  } else if (level.number > 0) {
    noStroke();
    fill(statusComplete);
  } else {
    noStroke();
    fill(statusDefault);
  }
  ellipse(51, 40, 20, 20);
  
  if (level.number == 1) {
    strokeWeight(1);
    stroke(statusActive);
    fill(statusDefault);
  } else if (level.number > 1) {
    noStroke();
    fill(statusComplete);
  } else {
    noStroke();
    fill(statusDefault);
  }
  ellipse(84, 40, 20, 20);
  
  if (level.number == 2) {
    strokeWeight(1);
    stroke(statusActive);
    fill(statusDefault);
  } else if (level.number > 2) {
    noStroke();
    fill(statusComplete);
  } else {
    noStroke();
    fill(statusDefault);
  }
  ellipse(117, 40, 20, 20);
  
  if (level.number == 3) {
    strokeWeight(1);
    stroke(statusActive);
    fill(statusDefault);
  } else if (level.number > 3) {
    noStroke();
    fill(statusComplete);
  } else {
    noStroke();
    fill(statusDefault);
  }
  ellipse(150, 40, 20, 20);
  
  if (level.number == 4) {
    strokeWeight(1);
    stroke(statusActive);
    fill(statusDefault);
  } else if (level.number > 4) {
    noStroke();
    fill(statusComplete);
  } else {
    noStroke();
    fill(statusDefault);
  }
  ellipse(183, 40, 20, 20);
  
  if (level.number == 5) {
    strokeWeight(1);
    stroke(statusActive);
    fill(statusDefault);
  } else if (level.number > 5) {
    noStroke();
    fill(statusComplete);
  } else {
    noStroke();
    fill(statusDefault);
  }
  ellipse(216, 40, 20, 20);
  
  if (level.number == 6) {
    strokeWeight(1);
    stroke(statusActive);
    fill(statusDefault);
  } else if (level.number > 6) {
    noStroke();
    fill(statusComplete);
  } else {
    noStroke();
    fill(statusDefault);
  }
  ellipse(249, 40, 20, 20);
  
  if (level.number == 7) {
    strokeWeight(1);
    stroke(statusActive);
    fill(statusDefault);
  } else if (level.number > 7) {
    noStroke();
    fill(statusComplete);
  } else {
    noStroke();
    fill(statusDefault);
  }
  ellipse(282, 40, 20, 20);
  
  if (level.number == 8) {
    strokeWeight(1);
    stroke(statusActive);
    fill(statusDefault);
  } else if (level.number > 8) {
    noStroke();
    fill(statusComplete);
  } else {
    noStroke();
    fill(statusDefault);
  }
  ellipse(315, 40, 20, 20);
  
  if (level.number == 9) {
    strokeWeight(1);
    stroke(statusActive);
    fill(statusDefault);
  } else if (level.number > 9) {
    noStroke();
    fill(statusComplete);
  } else {
    noStroke();
    fill(statusDefault);
  }
  ellipse(348, 40, 20, 20);
}
