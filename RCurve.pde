
/************************************************************************************/
/*************************************MAGIC HERE*************************************/
/************************************************************************************/
/************************************************************************************/
class RCurve {
  float[] points;
  
  void createPoints(float stepsize, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4 ) {
    points = createRCurvePoints(stepsize, new float[][] { {x1,y1,x2,y2,x3,y3,x4,y4}});
  }
  void createPoints(float stepsize, float[][] beziercurves ) {
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
          y = bezierPoint(y1,y1,y3,y4,lastbest);
        }
        lastx = x;
        lasty = y;
        points.add(x);
        points.add(y);
        //println("adding point at "+x+", "+y);
      }
    }
    
    float[] pointlist = new float[points.size()];
    for (int i=0; i<points.size(); i++) {
      pointlist[i] = (points.get(i));
      //println("adding "+pointlist[i]);
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

