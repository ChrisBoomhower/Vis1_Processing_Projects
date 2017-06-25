/*** Earthquake data related code ***/

// Check row count
int checkTable() {
  table = loadTable("earthquakeClean.csv", "header");

  return(table.getRowCount());
}

// Import new events only
void earthquakes() {
  table = loadTable("earthquakeClean.csv", "header");

  for (int i = readRows; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    mag = append(mag, row.getFloat("mag"));
    depth = append(depth, row.getFloat("depth"));
    latitude = append(latitude, row.getFloat("latitude"));
    longitude = append(longitude, row.getFloat("longitude"));
    delta = append(delta, row.getFloat("delta"));
    place = append(place, row.getString("place"));
    sig = append(sig, row.getInt("sig"));
    fc = append(fc, row.getFloat("t_lapsed"));
    dt = append(dt, row.getString("dateTime_UTC"));
    
    println("row = " + i + 
    ", Mag = " + mag[i] + 
    ", latitude = " + latitude[i] + 
    ", longitude = " + longitude[i] + 
    ", depth = " + depth[i] + 
    ", time delta = " + delta[i] + 
    ", place = " + place[i] + 
    ", sig = " + sig[i] +
    ", t_lapsed = " + fc[i]);
  }

  readRows = table.getRowCount();
}

// Display location details to screen
void location(int i) {
  float fadeScale = map(count, 0, 153, 0, 255);
  
  if (fadeScale < 128) fade++;
  else fade--;
  
  textSize(20);
  textAlign(LEFT);
  fill(0,map(fade, 0, 77, 0, 255));
  text("Location: " + place[i] + ",   Sig = " + sig[i] + ",   UTC Time = " + dt[i], 5, height - 5);
  
  textSize(12);
  text("Mag = " + mag[i], width/3 + 23, height/1.5 - 6);
  text("Depth = " + depth[i] + " km", width/3 + 23, height/1.5 + 6);
}