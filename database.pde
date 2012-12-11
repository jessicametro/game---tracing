/* THREE SIDED SHAPES */

void generateShape(GameLevel level, int numSides) {
  if (numSides == 3) {
    Shape levelShape = chooseShape3();
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

