Toggle ZoomRel; //<>// //<>// //<>// //<>//
Group PATCOGroup;
Group AGELVLTGroup;
Group WORKSCHTGroup;
Group SALLVLTGroup;

CheckBox CBCircleChartPATCO;
CheckBox CBCircleChartAGELVLT;
CheckBox CBCircleChartWORKSCHT;
CheckBox CBCircleChartSALLVLT;

Accordion CATaccordion;

class CircleChartRelationships extends Frame {

  Table circle;
  Table ageMag;
  Table workMag;
  Table sallMag;
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
  int[] agelvlTmagUnique = {};
  int[] workschTmagUnique = {};
  int[] sallvlTmagUnique = {};
  float[] CBCircleChartPATCOCurrentValues = new float[7];
  float[] CBCircleChartAGELVLTCurrentValues = new float[12];
  float[] CBCircleChartWORKSCHTCurrentValues = new float[10];
  float[] CBCircleChartSALLVLTCurrentValues = new float[19];

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


    PATCOGroup = cp5.addGroup("PATCOGroup")
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(75)
      ;

    CBCircleChartPATCO = cp5.addCheckBox("CBCircleChartPATCO")
      .setSize(int(frameWidth/35), int(frameHeight/40))
      .setPosition(10, 0)
      .setItemsPerRow(1)
      .setSpacingRow(height/200)
      .addItem("1,Professional", 0) // Don't need the numerical assignment, so setting to zero
      .addItem("2,Administrative", 0)
      .addItem("3,Technical", 0)
      .addItem("4,Clerical", 0)
      .addItem("5,Other White Collar", 0)
      .addItem("6,Blue Collar", 0)
      .addItem("9,Unspecified", 0)
      .activateAll()
      .moveTo(PATCOGroup)
      ;

    this.CBCircleChartPATCOCurrentValues = CBCircleChartPATCO.getArrayValue();

    AGELVLTGroup = cp5.addGroup("AGELVLTGroup")
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(140)
      ;

    CBCircleChartAGELVLT = cp5.addCheckBox("CBCircleChartAGELVLT")
      .setSize(int(frameWidth/35), int(frameHeight/40))
      .setPosition(10, 0)
      .setItemsPerRow(1)
      .setSpacingRow(height/200)
      .addItem("55-59", 0)
      .addItem("60-64", 0)
      .addItem("30-34", 0)
      .addItem("25-29", 0)
      .addItem("50-54", 0)
      .addItem("35-39", 0)
      .addItem("65 or more", 0)
      .addItem("45-49", 0)
      .addItem("40-44", 0)
      .addItem("20-24", 0)
      .addItem("Less than 20", 0)
      .addItem("Unspecified", 0)
      .activateAll()
      .moveTo(AGELVLTGroup)
      ;

    this.CBCircleChartAGELVLTCurrentValues = CBCircleChartAGELVLT.getArrayValue();

    WORKSCHTGroup = cp5.addGroup("WORKSCHTGroup")
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(120)
      ;

    CBCircleChartWORKSCHT = cp5.addCheckBox("CBCircleChartWORKSCHT")
      .setSize(int(frameWidth/35), int(frameHeight/40))
      .setPosition(10, 0)
      .setItemsPerRow(1)
      .setSpacingRow(height/200)
      .addItem("Full-time Nonseasonal", 0)
      .addItem("Intermittent Nonseasonal", 0)
      .addItem("Part-time Nonseasonal", 0)
      .addItem("Full-time Seasonal", 0)
      .addItem("Intermittent Seasonal", 0)
      .addItem("Part-time Seasonal", 0)
      .addItem("Part-time Job Sharer Nonseasonal", 0)
      .addItem("NO WORK SCHEDULE REPORTED", 0)
      .addItem("Part-time Job Sharer Seasonal", 0)
      .addItem("Full-time Nonseasonal Baylor Plan", 0)
      .activateAll()
      .moveTo(WORKSCHTGroup)
      ;

    this.CBCircleChartWORKSCHTCurrentValues = CBCircleChartWORKSCHT.getArrayValue();

    SALLVLTGroup = cp5.addGroup("SALLVLTGroup")
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(250)
      ;

    CBCircleChartSALLVLT = cp5.addCheckBox("CBCircleChartSALLVLT")
      .setSize(int(frameWidth/35), int(frameHeight/40))
      .setPosition(10, 0)
      .setItemsPerRow(1)
      .setSpacingRow(height/200)
      .addItem("$30,000 - $39,999", 0)
      .addItem("$40,000 - $49,999", 0)
      .addItem("$20,000 - $29,999", 0)
      .addItem("$50,000 - $59,999", 0)
      .addItem("$60,000 - $69,999", 0)
      .addItem("$70,000 - $79,999", 0)
      .addItem("$90,000 - $99,999", 0)
      .addItem("$80,000 - $89,999", 0)
      .addItem("$100,000 - $109,999", 0)
      .addItem("$110,000 - $119,999", 0)
      .addItem("$120,000 - $129,999", 0)
      .addItem("$130,000 - $139,999", 0)
      .addItem("$150,000 - $159,999", 0)
      .addItem("$180,000 or more", 0)
      .addItem("$140,000 - $149,999", 0)
      .addItem("Less than $20,000", 0)
      .addItem("$160,000 - $169,999", 0)
      .addItem("Unspecified or Zero", 0)
      .addItem("$170,000 - $179,999", 0)
      .activateAll()
      .moveTo(SALLVLTGroup)
      ;

    this.CBCircleChartSALLVLTCurrentValues = CBCircleChartSALLVLT.getArrayValue();

    CATaccordion = cp5.addAccordion("CATaccordion")
      .setPosition(x + frameWidth/30, y+height/25)
      .setWidth(int(frameWidth/3.85))
      .addItem(PATCOGroup)
      .addItem(AGELVLTGroup)
      .addItem(WORKSCHTGroup)
      .addItem(SALLVLTGroup)
      .hide()
      ;
  }

  void Construct() {
    ZoomRel.setPosition(x + frameWidth - frameWidth/17, y-height/30)
      .show();

    CATaccordion.setPosition(x + frameWidth/30, y+height/25)
      .setWidth(int(frameWidth/3.85))
      .show();

    //TableRow row = circle.getRow(0);
    float radius;
    int alignmentX;

    drawFrame();
    drawTitle("Key Attribute Relationships");

    pushMatrix();

    // Draw circle (center set as reference)
    translate(x + frameWidth/2, y + frameHeight/1.85);

    noFill();
    stroke(255);
    if (frameWidth < frameHeight) radius = frameWidth*0.8;
    else radius = frameHeight*0.6;
    ellipse(0, 0, radius, radius);

    // Determine attribute level coordinates and draw magnitude colors
    strokeWeight(getFrameWidth()/200);
    textSize(getFrameHeight()/50);

    alignmentX = 0;
    for (int i = 0; i < agelvlTUnique.length; i++) {
      int k = 30 + i*5;
      stroke(255, 0, 0, map(agelvlTmagUnique[i], min(agelvlTmag), max(agelvlTmag), 50, 255));
      //stroke(255, 0, 0);
      point(cos(radians(k))*(radius/1.95), sin(radians(k))*radius/1.95);
      drawLabels(agelvlTUnique, i, k, 0, radius, alignmentX);
    }

    alignmentX = 39;
    for (int i = 0; i < workschTUnique.length; i++) {
      int k = 150 + i*5;
      stroke(255, 255, 0, map(workschTmagUnique[i], min(workschTmagUnique), max(workschTmagUnique), 50, 255));
      //stroke(255, 255, 0);
      point(cos(radians(k))*(radius/1.95), sin(radians(k))*radius/1.95);
      drawLabels(workschTUnique, i, k, 180, radius, alignmentX);
    }

    alignmentX = 0;
    for (int i = 0; i < sallvlTUnique.length; i++) {
      int k = 240 + i*5;
      stroke(0, 255, 255, map(sallvlTmagUnique[i], min(sallvlTmag), max(sallvlTmag), 50, 255));
      //stroke(0, 255, 255);
      point(cos(radians(k))*(radius/1.95), sin(radians(k))*radius/1.95);
      drawLabels(sallvlTUnique, i, k, 0, radius, alignmentX);
    }

    // Observation triangles
    for (int i=0; i < patco.length; i++) {
      switch(patco[i]) {
      case 1:
        //println("patco 1");
        stroke(colorCycle[0]);
        break;
      case 2:
        //println("patco 2");
        stroke(colorCycle[1]);
        break;
      case 3:
        //println("patco 3");
        stroke(colorCycle[2]);
        break;
      case 4:
        //println("patco 4");
        stroke(colorCycle[3]);
        break;
      case 5:
        //println("patco 5");
        stroke(colorCycle[4]);
        break;
      case 6:
        //println("patco 6");
        stroke(colorCycle[5]);
        break;
      case 9:
        //println("patco 9");
        stroke(colorCycle[6]);
        break;
      }
      strokeWeight(map(cnt[i], 1, 3480, getFrameWidth()/2000, getFrameWidth()/100));
      beginShape();
      //println(agelvlT[i]);
      for (int j=0; j < agelvlTUnique.length; j++) {
        if (agelvlT[i].equals(agelvlTUnique[j])) {
          //print(agelvlT[i] + " " + agelvlTUnique[j]);
          //println("");
          vertex(cos(radians(30 + j*5))*(radius/2.1), sin(radians(30 + j*5))*radius/2.1);
        }
      }
      for (int j=0; j < workschTUnique.length; j++) {
        if (workschT[i].equals(workschTUnique[j])) {
          //print(workschT[i] + " " + workschT[j]);
          //println("");
          vertex(cos(radians(150 + j*5))*(radius/2.1), sin(radians(150 + j*5))*radius/2.1);
        }
      }
      for (int j=0; j < sallvlTUnique.length; j++) {
        if (sallvlT[i].equals(sallvlTUnique[j])) {
          //print(sallvlTUnique[i] + " " + sallvlTUnique[j]);
          //println("");
          vertex(cos(radians(240 + j*5))*(radius/2.1), sin(radians(240 + j*5))*radius/2.1);
        }
      }
      endShape(CLOSE);
    }
    strokeWeight(1);

    popMatrix();
  }

  void loadChartData() {
    patco             = new int[0];
    agelvlT           = new String[0];
    workschT          = new String[0];
    sallvlT           = new String[0];
    cnt               = new int[0];
    agelvlTmag        = new int[0];
    workschTmag       = new int[0];
    sallvlTmag        = new int[0];
    agelvlTUnique     = new String[0];
    agelvlTmagUnique  = new int[0];
    workschTUnique    = new String[0];
    workschTmagUnique = new int[0];
    sallvlTUnique     = new String[0];
    sallvlTmagUnique  = new int[0];
    circle            = loadTable("DistinctPATCO_AGELVL_WORKSCH_SALLVL_FINAL.csv", "header");
    ageMag            = loadTable("AGELVLTMagnitude.csv", "header");
    workMag           = loadTable("WORKSCHTMagnitude.csv", "header");
    sallMag           = loadTable("SALLVLTMagnitude.csv", "header");
    
    
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

    for (int i = 0; i < 10; i++) {
      println("CircleChart Line " + i + " = " + patco[i] + ", " + 
        agelvlT[i] + ", " + workschT[i] + ", " + sallvlT[i] + ", " + cnt[i] + 
        ", " + agelvlTmag[i] + ", " + workschTmag[i] + ", " + sallvlTmag[i]);
    }
    
    for (TableRow row : ageMag.rows()) {
      this.agelvlTUnique      =  append(agelvlTUnique, row.getString("AGELVLT"));
      this.agelvlTmagUnique   =  append(agelvlTmagUnique, row.getInt("AGELVLTMagnitude"));
    }
    
    for (TableRow row : workMag.rows()) {
      this.workschTUnique      =  append(workschTUnique, row.getString("WORKSCHT"));
      this.workschTmagUnique   =  append(workschTmagUnique, row.getInt("WORKSCHTMagnitude"));
    }
    
    for (int i = 0; i < workschTUnique.length; i++) {
      println(workschTUnique[i] + " " + workschTmagUnique[i]);
    }
    
    for (TableRow row : sallMag.rows()) {
      this.sallvlTUnique      =  append(sallvlTUnique, row.getString("SALLVLT"));
      this.sallvlTmagUnique   =  append(sallvlTmagUnique, row.getInt("SALLVLTMagnitude"));
    }
    
  }

  void drawLabels(String array[], int i, int k, int rot2, float radius, int alignmentX) {
    pushMatrix();
    translate(cos(radians(k))*(radius/1.9), sin(radians(k))*radius/1.9);
    pushMatrix();
    rotate(radians(k + rot2));
    textAlign(alignmentX, CENTER);
    text(array[i], 0, 0);
    popMatrix();
    popMatrix();
  }

  void cbPATCOAction() {
    print("got an event from "+CBCircleChartPATCO.getName()+"\t: ");
    for (int i=0; i<CBCircleChartPATCO.getArrayValue().length; i++) {
      int n = (int)CBCircleChartPATCO.getArrayValue()[i];
      int nCurrent = (int)this.CBCircleChartPATCOCurrentValues[i];

      if (n != nCurrent) {
        print("n" + n + "nCurrent" + nCurrent + "i" + i);
        println("Value Mismatch at Item Number - ", i);
        String catValue = null;

        switch(i) {
        case 0: 
          catValue = "1";
          break;
        case 1: 
          catValue = "2";
          break;
        case 2: 
          catValue = "3";
          break;
        case 3: 
          catValue = "4";
          break;
        case 4: 
          catValue = "5";
          break;
        case 5: 
          catValue = "6";
          break;
        case 6: 
          catValue = "9";
          break;
        }
        println("Loading Key Attribute Relationship Data for: ", n, "PATCO", "\"" + catValue + "\"");
        execPython.Exec(n, "PATCO", "\"" + catValue + "\"");
        loadChartData();
      }
    }

    this.CBCircleChartPATCOCurrentValues = CBCircleChartPATCO.getArrayValue();
  }

  void cbAGELVLTAction() {
    print("got an event from "+CBCircleChartAGELVLT.getName()+"\t: ");
    for (int i=0; i<CBCircleChartAGELVLT.getArrayValue().length; i++) {
      int n = (int)CBCircleChartAGELVLT.getArrayValue()[i];
      int nCurrent = (int)this.CBCircleChartAGELVLTCurrentValues[i];

      if (n != nCurrent) {
        println("Value Mismatch at Item Number - ", i);
        String catValue = null;

        switch(i) {
        case 0:  
          catValue = "55-59";
          break;
        case 1:  
          catValue = "60-64";
          break;
        case 2:  
          catValue = "30-34";
          break;
        case 3:  
          catValue = "25-29";
          break;
        case 4:  
          catValue = "50-54";
          break;
        case 5:  
          catValue = "35-39";
          break;
        case 6:  
          catValue = "65 or more";
          break;
        case 7:  
          catValue = "45-49";
          break;
        case 8:  
          catValue = "40-44";
          break;
        case 9:  
          catValue = "20-24";
          break;
        case 10: 
          catValue = "Less than 20";
          break;
        case 11: 
          catValue = "Unspecified";
          break;
        }
        println("Loading Key Attribute Relationship Data for: ", n, "AGELVLT", "\"" + catValue + "\"");
        execPython.Exec(n, "AGELVLT", "\"" + catValue + "\"");
        loadChartData();
      }
    }


    this.CBCircleChartAGELVLTCurrentValues = CBCircleChartAGELVLT.getArrayValue();
  }

  void cbWORKSCHTAction() {
    print("got an event from "+CBCircleChartWORKSCHT.getName()+"\t: ");
    for (int i=0; i<CBCircleChartWORKSCHT.getArrayValue().length; i++) {
      int n = (int)CBCircleChartWORKSCHT.getArrayValue()[i];
      int nCurrent = (int)this.CBCircleChartWORKSCHTCurrentValues[i];

      if (n != nCurrent) {
        println("Value Mismatch at Item Number - ", i);
        String catValue = null;
        println("switch:", i);
        switch(i) {
        case 0:  
          catValue = "Full-time Nonseasonal";
          break;
        case 1:  
          catValue = "Intermittent Nonseasonal";
          break;
        case 2:  
          catValue = "Part-time Nonseasonal";
          break;
        case 3:  
          catValue = "Full-time Seasonal";
          break;
        case 4:  
          catValue = "Intermittent Seasonal";
          break;
        case 5:  
          catValue = "Part-time Seasonal";
          break;
        case 6:  
          catValue = "Part-time Job Sharer Nonseasonal";
          break;
        case 7:  
          catValue = "NO WORK SCHEDULE REPORTED";
          break;
        case 8:  
          catValue = "Part-time Job Sharer Seasonal";
          break;
        case 9:  
          catValue = "Full-time Nonseasonal Baylor Plan";
          break;
        }
        println("Loading Key Attribute Relationship Data for: ", n, "WORKSCHT", "\"" + catValue + "\"");
        execPython.Exec(n, "WORKSCHT", "\"" + catValue + "\"");
        loadChartData();
      }
    }  

    this.CBCircleChartWORKSCHTCurrentValues = CBCircleChartWORKSCHT.getArrayValue();
  }

  void cbSALLVLTAction() {
    print("got an event from "+CBCircleChartSALLVLT.getName()+"\t: ");
    for (int i=0; i<CBCircleChartSALLVLT.getArrayValue().length; i++) {
      int n = (int)CBCircleChartSALLVLT.getArrayValue()[i];
      int nCurrent = (int)this.CBCircleChartSALLVLTCurrentValues[i];

      if (n != nCurrent) {
        println("Value Mismatch at Item Number - ", i);
        String catValue = null;

        switch(i) {
        case 0:   
          catValue = "$30,000 - $39,999";
          break;
        case 1:   
          catValue = "$40,000 - $49,999";
          break;
        case 2:   
          catValue = "$20,000 - $29,999";
          break;
        case 3:   
          catValue = "$50,000 - $59,999";
          break;
        case 4:   
          catValue = "$60,000 - $69,999";
          break;
        case 5:   
          catValue = "$70,000 - $79,999";
          break;
        case 6:   
          catValue = "$90,000 - $99,999";
          break;
        case 7:   
          catValue = "$80,000 - $89,999";
          break;
        case 8:   
          catValue = "$100,000 - $109,999";
          break;
        case 9:   
          catValue = "$110,000 - $119,999";
          break;
        case 10:  
          catValue = "$120,000 - $129,999";
          break;
        case 11:  
          catValue = "$130,000 - $139,999";
          break;
        case 12:  
          catValue = "$150,000 - $159,999";
          break;
        case 13:  
          catValue = "$180,000 or more";
          break;
        case 14:  
          catValue = "$140,000 - $149,999";
          break;
        case 15:  
          catValue = "Less than $20,000";
          break;
        case 16:  
          catValue = "$160,000 - $169,999";
          break;
        case 17:  
          catValue = "Unspecified or Zero";
          break;
        case 18:  
          catValue = "$170,000 - $179,999";
          break;
        }
        println("Loading Key Attribute Relationship Data for: ", n, "SALLVLT", "\"" + catValue + "\"");
        execPython.Exec(n, "SALLVLT", "\"" + catValue + "\"");
        loadChartData();
      }
    }  

    this.CBCircleChartSALLVLTCurrentValues = CBCircleChartSALLVLT.getArrayValue();
  }
}