/**** xy translations and ellipse ping related code ****/

PVector getxy(float longitude, float latitude) {

  // get x value  
  float x = (longitude+180)*(mapWidth/360);

  // convert from degrees to radians
  float latRad = latitude*PI/180;

  // get y value
  float mercN = log(tan((PI/4)+(latRad/2)));
  float y     = (mapHeight/2)-(mapHeight*mercN/(2*PI));

  PVector xy = new PVector(x, y);
  return xy;
}

void pingQuake(float longitude, float latitude, float mag, int sig) {
  PVector xy = getxy(longitude, latitude);

  float s = map(sig, 0, 1000, 0, 255);
  noStroke();
  fill(255, 0, 0, 255);//s);
  ellipse(map(xy.x, tlCorner.x, brCorner.x, 0, width), //map adjusts for zoomX
    map(xy.y, tlCorner.y, brCorner.y, 0, height), //map adjusts for zoomY
    mag*6, 
    mag*6);
  
  if (first == 0) {
    first = frameCount;
    //newFrame = frameCount;
  }
  //else if (waveCount > 0) newFrame = frameCount;
    
  //return (frameCount);
}