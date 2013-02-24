class SHAPES{
  int maxnv = 4000;
  int lv;
  int av;
  float[] lengths = new float[maxnv];
  float[] angles = new float[maxnv];
  SHAPES(){} 
  
  void addLength(pt A, pt B){
    lengths[lv++] = d(A,B);
  }
  
  void addAngle(pt A, pt B, pt C){
    angles[av++] = turnAngle(A,B,C);;
  }
  
  //Convert the current shape to a stroke constrained by A and B
  STROKES convertStroke(pt A, pt B){
    pt newPts[] = new pt[maxnv];
    float relAngle = 0; //keep track of relative angle
    newPts[0] = A; //start at A
    pt nextPoint = new pt(A.x+cos(0)*lengths[0],A.y+sin(0)*lengths[0]); //parallel to the x-axis
    newPts[1] = nextPoint;
    int nv = 2; //first 2 points added
    for (int v=1; v<lv; v++){
      relAngle+=angles[v-1];//retrieve angle
      nextPoint = new pt(nextPoint.x+cos(relAngle)*lengths[v],nextPoint.y+sin(relAngle)*lengths[v]);
      newPts[nv++] = nextPoint;
    }
    STROKES newStroke = new STROKES();
    for( int i=0;i<nv;i++){
      newStroke.addPt(newPts[i]);  
    }
    return newStroke.scaleRotateTrans(A,B);
  }
  
  
  void draw(){
    if(lv>0){
      float relAngle = 0;
      beginShape();
      pt cen = new pt(250,300);
      cen.show().v();
      pt nextPoint = new pt(cen.x+cos(0)*lengths[0],cen.y+sin(0)*lengths[0]);
      nextPoint.show().v();
      for (int v=1; v<lv; v++){
        relAngle+=angles[v-1];
        nextPoint = new pt(nextPoint.x+cos(relAngle)*lengths[v],nextPoint.y+sin(relAngle)*lengths[v]);
        nextPoint.show().v();
      }
      endShape();
    }
  }
  
}
