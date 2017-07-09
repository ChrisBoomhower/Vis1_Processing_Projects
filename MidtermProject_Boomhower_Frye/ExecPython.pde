/**********************************************************
 Class used to Execute Python Script
 ***********************************************************/

/***TEMP VARIABLES FOR INPUT CMD***/
/***These will be replaced by class objects later***/
/***startQTR and endQTR is ALWAYS assigned the qtr number selected in the slider as a string***/
/***IF SEP Type is to be included.. value = SEP Code***/
/***IF SEP Type is NOT to be included.. value = ""***/
String startQTR = "1";
String endQTR   = "3";
String SEP_NS   = "NS";
String SEP_SA   = "SA";
String SEP_SC   = "";
String SEP_SD   = "SD";
String SEP_SH   = "SH";
String SEP_SI   = "SI";
String SEP_SJ   = "";
/******/

import deadpixel.command.Command;
Command cmd;


class ExecPython { 

  private String APP  = "python ";
  private String FILE = "parseData.py";
  private String dataPath = "cd /D \""+dataPath("")+ "\"";
  private String PythonFilesPath = sketchPath()+"\\PythonFiles\\";

  ExecPython(String startQTR, String endQTR, String SEP_NS, String SEP_SA, String SEP_SC, 
             String SEP_SD, String SEP_SH, String SEP_SI, String SEP_SJ) {
    cmd = new Command("cmd.exe /c " + dataPath + " && " + APP + "\"" + PythonFilesPath + FILE + "\"" 
                      + " " + startQTR + " " + endQTR + " " + SEP_NS + " " + SEP_SA + " " + SEP_SC + " " 
                      + SEP_SD + " " + SEP_SH + " " + SEP_SI + " " + SEP_SJ);
    cmd.run();
  }
}