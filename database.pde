

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
