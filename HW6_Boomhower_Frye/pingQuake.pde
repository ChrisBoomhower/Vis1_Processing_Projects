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

void pingQuake(float longitude, float latitude) {
  PVector xy = getxy(longitude, latitude);

  ellipse(map(xy.x, tlCorner.x, brCorner.x, 0, width), //map adjusts for zoomX
    map(xy.y, tlCorner.y, brCorner.y, 0, height), //map adjusts for zoomY
    5, 
    5);
}