/****************************************************************************************** //<>//
 Title         : EarthQuakes
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 6/24/2017
 Assignment    : MSDS6390 - HW 6
 Instructions  : N/A
 Resources     : https://stackoverflow.com/questions/14329691/covert-latitude-longitude-point-to-a-pixels-x-y-on-mercator-projection
 https://www.openstreetmap.org/export#map=3/55.18/-108.02
 
 ******************************************************************************************/


float mapWidth    = 1162; // don't mess with me!
float mapHeight   = 976; // don't mess with me!
PVector tlCornerRaw, brCornerRaw;   // Map corners raw in WebMercator coordinates.
PVector tlCorner, brCorner;         // Map corners converted in WebMercator coordinates.
PImage backgroundMap;

Table table;
float[] mag = {};
float[] depth = {};
float[] latitude = {};
float[] longitude = {};
float[] delta = {};
String[] place = {};
String[] dt = {};
int[] sig = {};
float[] fc = {};
int readRows = 0;
int first = 0;
int waveCount = 0;
int count = 0;
float fade = 0;
boolean quiet = true;
//float newFrame = 0;

void setup() {
  //PImage backgroundMap = loadImage("data/USA.jpg");
  backgroundMap = loadImage("data/USA.jpg");

  size(1162, 976);
  backgroundMap.resize(1162, 976);
  //background(backgroundMap);
  image(backgroundMap, 0, 0, width, height);

  //define zoom lat/long

  tlCornerRaw = new PVector(-168.4, 71.75); // don't mess with me!
  brCornerRaw = new PVector(-66.27, 18.48); // don't mess with me!

  tlCorner = getxy(tlCornerRaw.x, tlCornerRaw.y); 
  brCorner = getxy(brCornerRaw.x, brCornerRaw.y);
}

void draw() {
  image(backgroundMap, 0, 0, width, height);
  
  // Grab new live data if available
  int rows = checkTable();
  if (rows - readRows > 0) earthquakes();

  //float latitude    = random(brCornerRaw.y, tlCornerRaw.y);    //19.8968;   //41.145556; // (φ) // y
  //float longitude   = random(tlCornerRaw.x, brCornerRaw.x);    //-155.5828; //-73.995;   // (λ) // x

  // Activity based on whether earthquake timing
  for (int i = 0; i < mag.length; i++) { 
    if ((frameCount - first)/60 >= fc[i]) { //Generate dots at 2x speed
      pingQuake(longitude[i], latitude[i], mag[i], sig[i]);
      wave(i, mag[i], depth[i]);
    }
  }
  
  // Draw straight lines for curve if no data yet exists in live data source
  if (first == 0) {
    stroke(30, 132, 73);
    line(20, height/1.5, width/3 + 13, height/1.5);
  }
  
  // Write time elapsed since sketch start
  textSize(12);
  textAlign(RIGHT);
  fill(0);
  text("Time Elapsed = " + millis()/1000, width - 5, height-5);
}