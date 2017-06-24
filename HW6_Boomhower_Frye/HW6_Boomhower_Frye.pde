/****************************************************************************************** //<>//
 Title         : EarthQuakes
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 6/24/2017
 Assignment    : MSDS6390 - HW 6
 Instructions  : N/A
 Resources     : https://stackoverflow.com/questions/14329691/covert-latitude-longitude-point-to-a-pixels-x-y-on-mercator-projection
 https://www.openstreetmap.org/export#map=3/55.18/-108.02
 
 ******************************************************************************************/


float mapWidth    = 581; // don't mess with me!
float mapHeight   = 488; // don't mess with me!
PVector tlCornerRaw, brCornerRaw;   // Map corners raw in WebMercator coordinates.
PVector tlCorner, brCorner;         // Map corners converted in WebMercator coordinates.

void setup() {
  PImage backgroundMap = loadImage("data/USA.jpg");

  size(581, 488);
  background(backgroundMap);

  frameRate(10);

  //define zoom lat/long

  tlCornerRaw = new PVector(-168.4, 71.75); // don't mess with me!
  brCornerRaw = new PVector(-66.27, 18.48); // don't mess with me!

  tlCorner = getxy(tlCornerRaw.x, tlCornerRaw.y); 
  brCorner = getxy(brCornerRaw.x, brCornerRaw.y);
}

void draw() {

  float latitude    = random(brCornerRaw.y, tlCornerRaw.y);    //19.8968;   //41.145556; // (φ) // y
  float longitude   = random(tlCornerRaw.x, brCornerRaw.x);    //-155.5828; //-73.995;   // (λ) // x

  pingQuake(longitude, latitude);
}