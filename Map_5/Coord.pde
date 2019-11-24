class Coord { //calculating x and y co-ordinates for cities based on latitude and longitude information
  float a, b, c;
  float x, y, lat, lon;
  float zoom = 1;
  Coord (float nlat, float nlon){
   lat = nlat;
   lon = nlon;
   x = mercX(lon) - mercX(0);
   y = mercY(lat) - mercY(0);
   
  }

  float mercX (float lon) {
    lon = radians (lon);
    float a = (315/PI) * pow(2,zoom);
    float b = lon + PI;
    return a * b;
  }

  float mercY(float lat) {
    lat = radians(lat);
    float a = (315/PI) * pow(2,zoom);
    float b = tan(PI / 4 + lat / 2);
    float c = PI - log(b);
    return a * c;
  }

  void drawMapPoint (){ //plotting a marker at every city in the database
   
    noStroke();
    fill (255,255,255);
    ellipse (x,y,8,8);
   
  }
}
