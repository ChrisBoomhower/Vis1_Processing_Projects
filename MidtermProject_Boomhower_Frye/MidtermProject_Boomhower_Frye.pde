/****************************************************************************************** //<>// //<>// //<>//
 Title         : OPM Separation Analysis Dashboard
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 7/9/2017
 Assignment    : MSDS6390 - Midterm Project
 Resources     : https://Forum.Processing.org/two/discussion/23324/executing-python-3-code-from-within-processing#Item_9
                 https://GitHub.com/GoToLoop/command/blob/patch-1/src/deadpixel/command/Command.java
 ******************************************************************************************/

ExecPython execPython;
 
void setup() {

  //these variables will be replaced by inputs from class object variable getter method calls. 
  //no need to assign to variable... just exec the declaration method each time we need to run new files
  //setup will need to establish default values for all these class variables for the FULL Dataset. 
    //Then actions will update the variables and resubmit thefile generation
new ExecPython(startQTR, endQTR, SEP_NS, SEP_SA, SEP_SC, SEP_SD, SEP_SH, SEP_SI, SEP_SJ);

}