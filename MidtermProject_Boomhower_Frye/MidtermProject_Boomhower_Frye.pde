/** 
 * Python Command (v1.0.1)
 * GoToLoop (2017/Jul/05)
 *
 * https://Forum.Processing.org/two/discussion/23324/
 * executing-python-3-code-from-within-processing#Item_9
 *
 * https://GitHub.com/GoToLoop/command/blob/patch-1/src/
 * deadpixel/command/Command.java
 */
 
import deadpixel.command.Command;
Command cmd;
 
String APP  = "python ";
String FILE = "parseData.py";
 
void setup() {
  String dataPath = "cd /D \""+dataPath("")+ "\"";
  String PythonFilesPath = sketchPath()+"\\PythonFiles\\";

  cmd = new Command("cmd.exe /c " + dataPath + " && " + APP + "\"" + PythonFilesPath + FILE + "\"" + " 1" + " 0");
  
  boolean success = cmd.run();
  print("Success:", success);
}