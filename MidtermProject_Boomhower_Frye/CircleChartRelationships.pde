Toggle ZoomRel;

class CircleChartRelationships extends Frame {

  Table circle;
  int[] patco = {};
  String[] agelvlT = {};
  String[] workschT = {};
  String[] sallvlT = {};
  int[] cnt = {};
  int[] agelvlTmag = {};
  int[] workschTmag = {};
  int[] sallvlTmag = {};
  int[] patcoUnique = {};
  String[] agelvlTUnique = {};
  String[] workschTUnique = {};
  String[] sallvlTUnique = {};
  //int[] agelvlTmagUnique = {};
  //int[] workschTmagUnique = {};
  //int[] sallvlTmagUnique = {};
  
  CircleChartRelationships() {
  }

  CircleChartRelationships(float x, float y, float frameWidth, float frameHeight) {
    super(x, y, frameWidth, frameHeight);
    ZoomRel = cp5.addToggle("ZoomRel")
      .setPosition(x + frameWidth - frameWidth/17, y-height/30)
      .setSize(width/55, height/60)
      .setValue(false)
      .setMode(ControlP5.SWITCH)
      .hide()
      ;
  }

  void Construct() {
    ZoomRel.setPosition(x + frameWidth - frameWidth/17, y-height/30)
      .show();
    //TableRow row = circle.getRow(0);
    float radius;
    int colorPosition = 0;
    
    drawFrame();
    drawTitle("CIRCLECHARTRELATIONSHIPS TITLE HERE");

    pushMatrix();

    // Draw circle (center set as reference)
    translate(x + frameWidth/2, y + frameHeight/1.85);
    
    noFill();
    stroke(255);
    if (frameWidth < frameHeight) radius = frameWidth*0.8;
    else radius = frameHeight*0.8;
    ellipse(0, 0, radius, radius);
    
    // Determine attribute level coordinates and draw magnitude colors
    strokeWeight(getFrameWidth()/200);
    textSize(getFrameHeight()/50);
    //for (int i = 30; i < (30 + agelvlTUnique.length * 5); i=i+5) {
    for (int i = 0; i < agelvlTUnique.length; i++) {
      int k = 30 + i*5;
      stroke(255, 0, 0, map(agelvlTmag[k], min(agelvlTmag), max(agelvlTmag), 0, 255)); //<>//
      point(cos(radians(k))*(radius/1.95), sin(radians(k))*radius/1.95);
      pushMatrix();
      translate(cos(radians(k))*(radius/1.9), sin(radians(k))*radius/1.9);
      pushMatrix();
      rotate(radians(k));
      textAlign(LEFT);
      text("test", 0, 0);
      popMatrix();
      popMatrix();
    }

    //for (int i = 150; i < (150 + workschTUnique.length * 5); i=i+5) {
    for (int i = 0; i < workschTUnique.length; i++) {
      int k = 150 + i*5;
      stroke(255, 255, 0, map(workschTmag[k], min(workschTmag), max(workschTmag), 0, 255));
      point(cos(radians(k))*(radius/1.95), sin(radians(k))*radius/1.95);
      pushMatrix();
      translate(cos(radians(k))*(radius/1.9), sin(radians(k))*radius/1.9);
      pushMatrix();
      rotate(radians(k+180));
      textAlign(RIGHT);
      text("test", 0, 0);
      popMatrix();
      popMatrix();
    }

    //for (int i = 240; i < (240 + sallvlTUnique.length * 5); i=i+5) {
    for (int i = 0; i < workschTUnique.length; i++) {
      int k = 240 + i*5;
      stroke(0, 255, 255, map(sallvlTmag[k], min(sallvlTmag), max(sallvlTmag), 0, 255));
      point(cos(radians(k))*(radius/1.95), sin(radians(k))*radius/1.95);
      pushMatrix();
      translate(cos(radians(k))*(radius/1.9), sin(radians(k))*radius/1.9);
      pushMatrix();
      rotate(radians(k));
      textAlign(LEFT);
      text("test", 0, 0);
      popMatrix();
      popMatrix();
    }
    
    // Observation triangles
    for (int i=0; i < patco.length; i++) {
      if (colorPosition>colorCycle.length-1) colorPosition = 0;
      stroke(colorCycle[colorPosition]);
      strokeWeight(map(cnt[i], 1, 3480, getFrameWidth()/2000, getFrameWidth()/100));
      beginShape();
      for (int j=0; j < agelvlTUnique.length; j++) {
        if (agelvlT[i].contains(agelvlTUnique[j])) { //<>//
          vertex(cos(radians(30 + j*5))*(radius/2.1), sin(radians(30 + j*5))*radius/2.1);
        }
      }
      for (int j=0; j < workschTUnique.length; j++) {
        if (workschT[i].contains(workschTUnique[j])) {
          vertex(cos(radians(150 + j*5))*(radius/2.1), sin(radians(150 + j*5))*radius/2.1);
        }
      }
      for (int j=0; j < sallvlTUnique.length; j++) {
        if (sallvlT[i].contains(sallvlTUnique[j])) {
          vertex(cos(radians(240 + j*5))*(radius/2.1), sin(radians(240 + j*5))*radius/2.1);
        }
      }
      endShape(CLOSE);
      colorPosition++;
    }
    strokeWeight(1);
    
    popMatrix();
  }

  void loadChartData(){
    patco        = new int[0];
    agelvlT      = new String[0];
    workschT     = new String[0];
    sallvlT      = new String[0];
    cnt          = new int[0];
    agelvlTmag   = new int[0];
    workschTmag  = new int[0];
    sallvlTmag   = new int[0];
    circle = loadTable("DistinctPATCO_AGELVL_WORKSCH_SALLVL_FINAL.csv", "header");

    for (TableRow row : circle.rows()) {
      this.patco        =  append(patco, row.getInt("PATCO"));
      this.agelvlT      =  append(agelvlT, row.getString("AGELVLT"));
      this.workschT     =  append(workschT, row.getString("WORKSCHT"));
      this.sallvlT      =  append(sallvlT, row.getString("SALLVLT"));
      this.cnt          =  append(cnt, row.getInt("CNT"));
      this.agelvlTmag   =  append(agelvlTmag, row.getInt("AGELVLTMagnitude"));
      this.workschTmag  =  append(workschTmag, row.getInt("WORKSCHTMagnitude"));
      this.sallvlTmag   =  append(sallvlTmag, row.getInt("SALLVLTMagnitude"));
    }
    
    //for (int i = 0; i < this.patco.length; i++) { //<>//
    //  println("CircleChart Line " + i + " = " + patco[i] + ", " + 
    //    agelvlT[i] + ", " + workschT[i] + ", " + sallvlT[i] + ", " + cnt[i] + 
    //    ", " + agelvlTmag[i] + ", " + workschTmag[i] + ", " + sallvlTmag[i]);
    //}
    
    patcoUnique = getUniqueInt(this.patco);
    agelvlTUnique = getUniqueString(this.agelvlT);
    workschTUnique = getUniqueString(this.workschT);
    sallvlTUnique = getUniqueString(this.sallvlT);
    //agelvlTmagUnique = getUniqueInt(this.agelvlTmag);
    //workschTmagUnique = getUniqueInt(this.workschTmag);
    //sallvlTmagUnique = getUniqueInt(this.sallvlTmag);
    
    print("PATCO unique = ");
    for (int i = 0; i < patcoUnique.length; i++) print(patcoUnique[i] + ", ");
    print("\n");
    
    print("AGELVLT unique = ");
    for (int i = 0; i < agelvlTUnique.length; i++) print(agelvlTUnique[i] + ", ");
    print("\n");
    
    print("WORKSCHT unique = ");
    for (int i = 0; i < workschTUnique.length; i++) print(workschTUnique[i] + ", ");
    print("\n");
    
    print("SALLVLT unique = ");
    for (int i = 0; i < sallvlTUnique.length; i++) print(sallvlTUnique[i] + ", ");
    print("\n");
  }
  
  int[] getUniqueInt(int[] input) {
    int[] temp = new int[input.length];
    int p = 1;
    Arrays.sort(input);
    temp[0] = input[0];
    for (int i = 1; i < input.length; i++)
      if (input[i] != input[i-1])
        temp[p++] = input[i];
    int[] output =  new int[p];
    arrayCopy(temp, 0, output, 0, p);
    return output;
  }
  
  String[] getUniqueString(String[] input) {
    String[] temp = new String[input.length];
    int p = 1;
    Arrays.sort(input);
    temp[0] = input[0];
    for (int i = 1; i < input.length; i++)
      if (!input[i].contains(input[i-1]))
        temp[p++] = input[i];
    String[] output =  new String[p];
    arrayCopy(temp, 0, output, 0, p);
    return output;
  }
  
}