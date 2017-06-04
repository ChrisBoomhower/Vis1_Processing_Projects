/******************************************************************************************
Generates Round Selector. 
Use Coordinates from Round Selectors for mouseClicks
Add accent on flags when selected
only clicking start will assign the round variable
******************************************************************************************/

void roundSelector(float x, float y){
  
  // use x and y mouse coordinates to identify which round is clicked
  
  int roundTemp;
  
  roundTemp = 1;
  round = roundTemp;
  
  speedX = 5;
  
  loop();
  
}