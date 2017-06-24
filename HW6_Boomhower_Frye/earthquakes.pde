int checkTable() {
  table = loadTable("earthquakeClean.csv", "header");

  return(table.getRowCount());
}

void earthquakes() {
  table = loadTable("earthquakeClean.csv", "header");

  for (int i = readRows; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    mag = append(mag, row.getFloat("mag"));
    depth = append(depth, row.getFloat("depth"));
    latitude = append(latitude, row.getFloat("latitude"));
    longitude = append(longitude, row.getFloat("longitude"));
    time = append(time, row.getFloat("time"));
    place = append(place, row.getString("place"));
    sig = append(sig, row.getInt("sig"));
  }
  for (int i = 0; i < mag.length; i++) {
    println("Mag = " + mag[i] + ", latitude = " + latitude[i] + ", longitude = " + longitude[i] + ", depth = " + depth[i] + ", time = " + time[i] + ", place = " + place[i] + ", sig = " + sig[i]);
  }
  readRows = table.getRowCount();
}