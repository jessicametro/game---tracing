/* THREE SIDED SHAPES */

void generateShape(GameLevel level, int numSides) {
  if (numSides == 3) {
    Shape levelShape = chooseShape3();
    insertPoints(level, levelShape);
  } else if (numSides == 4) {
    Shape levelShape = chooseShape4();
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




/* six sides 

Shape generateShape5D() {
  Shape s5D = new Shape();
  s5D.points = new float[][] { {80, 320}, {80, 240}, {200, 120}, {240, 200}, {320, 240}, {320, 320}, {80, 320} };
  return s5D;
}

*/
