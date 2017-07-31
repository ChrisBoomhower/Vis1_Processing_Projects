/**********************************************************
 Class used to Execute Python Script
 ***********************************************************/

import deadpixel.command.Command;
Command cmd;

class ExecPython { 

  private final String APP  = "python ";
  private String FILE;
  private final String dataPath = "cd /D \""+dataPath("")+ "\"";
  private final String PythonFilesPath = sketchPath()+"\\PythonFiles\\";

  ExecPython() {
  }

  void Exec(int startQTR, int endQTR, String SEP_NS, String SEP_SA, String SEP_SC, 
    String SEP_SD, String SEP_SH, String SEP_SI, String SEP_SJ) {

    FILE = "parseData.py";  

    cmd = new Command("cmd.exe /c " + dataPath + " && " + APP + "\"" + PythonFilesPath + FILE + "\"" 
      + " " +startQTR + " " + endQTR + " " + SEP_NS + " " + SEP_SA + " " + SEP_SC + " " 
      + SEP_SD + " " + SEP_SH + " " + SEP_SI + " " + SEP_SJ);

    cmd.run();
  }

  void Exec(int addRemove, String catType, String catValue) {

    FILE = "parseKeyAttributeRelationships.py";

    cmd = new Command("cmd.exe /c " + dataPath + " && " + APP + "\"" + PythonFilesPath + FILE + "\"" 
      + " " +addRemove + " " + catType + " " + catValue);

    cmd.run();
  }
}