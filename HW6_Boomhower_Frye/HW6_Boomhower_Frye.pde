/****************************************************************************************** //<>//
 Title         : EarthQuakes
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 6/24/2017
 Assignment    : MSDS6390 - HW 6
 Instructions  : This sketch imports and visualizes a live stream of earthquake reports from the earthquakeClean.csv file in the data folder.
                 Earthquake magnitude and depth are plotted in real-time along with location, significance, and time details. The CSV data file is
                 populated with live earthquake data from the U.S. Geological Survey (USGS) via our earthquake.py Python script. Running our
                 Python script opens a live connection with the USGS earthquake report feed via the "satori.rtm.client" Python library which
                 must be installed before running (pip install satori.rtm.client). The script should be run at the same time as the Processing
                 sketch to visualize live data as earthquakes occur throughout the U.S. However, the Python script may also be run ahead of
                 time since it simply updates earthquakeClean.csv as new events are reported (This Processing sketch may read from the CSV
                 both while running the Python script and while not).
                 
                 Therefore, for demonstration purposes, we've submitted our assignment with the CSV populated with data output from our most recent Python
                 script run. To visualize the data, simply run the sketch, but note that the timing of earthquake updates is based on the t_lapsed column
                 which is the time, in seconds, between each earthquake event. Therefore, if the second earthquake is 16 seconds after the first
                 one, for example, then you will have to wait 16 seconds from the first earthquake before the visualization is updated and the
                 earthquake magnitude and depth are animated via the line plots in the left side of the window. If the t_lapsed value for the third
                 earthquake is 30, this means it occurred 30 seconds after the first earthquake (the column is a cumulative sum with respect to the
                 first event). For grading, you may always alter the t_lapsed values in the earthquakeClean.csv manually to speed up their occurrences
                 (assuming you do not have the Python script running which will immediately overwrite your changes). To visualize live data, just
                 clear the contents of the earthquakeClean.csv (while leaving the header row) and then start the Python script before running this
                 Processing sketch. It's just a matter of time before you capture and visualize the first earthquake event (they occur more often
                 than you'd think)!
                 
 Resources     : https://stackoverflow.com/questions/14329691/covert-latitude-longitude-point-to-a-pixels-x-y-on-mercator-projection
                 https://www.openstreetmap.org/export#map=3/55.18/-108.02
                 https://www.openprocessing.org/sketch/403977
                 https://www.satori.com/channels/USGS-Earthquakes
 
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