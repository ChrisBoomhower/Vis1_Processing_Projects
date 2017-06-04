/******************************************************************************************
Generates Round Selector. 
Use Coordinates from Round Selectors for mouseClicks
Add accent on flags when selected
only clicking start will assign the round variable
******************************************************************************************/

void roundSelector(float x, float y){
  
  // use x and y mouse coordinates to identify which round is clicked
  
  int roundTemp;
  
  roundTemp = 1; // roundTemp will be assigned as staging selection until the start button is clicked
  round = roundTemp; // once start button is clicked, this may occur
  
  for(int i = 0; i<ballCount; i++){
  speedX[i] = 5;
  }  
  loop();
  
}