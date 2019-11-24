class CityArcs {
  float arcCentralAngle = HALF_PI;
  
  // transparency value
  int REGULAR_TRANSPARENCY = 100;
  int DIM_TRANSPARENCY = 30;
  int BRIGHT_TRANSPARENCY = 180;
  
  int[] monthRadii = {0, 6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 61};
  int arcWeight = 3;
  Legend legend = new Legend(); //fetching colour palette from the legend
  
  public void setTempColor(float temp, int transparency) { //finding right colour based on temperature value for every data point
    int step = (int) Math.min(Math.max((20 + temp) / 10 + 1, 0), 7);
    stroke(legend.colors[step], transparency);
    fill(legend.colors[step], transparency);
  }
  
  public void drawMonth(Coord coord, int month, float directionAngle, int radiusOffset) { //Each arc represents 1 data point i.e. the temperature for one month in the selected year for the city
    strokeWeight(arcWeight);
    arc(coord.x, coord.y, 2 * (monthRadii[month] + radiusOffset), 2 * (monthRadii[month] + radiusOffset), directionAngle, directionAngle + arcCentralAngle);
  }
  
  public void drawArcs(City city, int transparency, int radiusOffset) { //draw arcs for all 12 months for the city starting at same angle every time
    for (int month = 12; month > 0 ; month--) {
      setTempColor(city.temperatures[month], transparency);
      drawMonth(city.coord, month, month * PI * 7 / 8, radiusOffset);
    }
  }
  
  public void drawArcs(City city, float offsetAngle, int transparency, int radiusOffset) { //draw arcs for all 12 months of a city starting at different angle everytime
    for (int month = 12; month > 0 ; month--) {
      setTempColor(city.temperatures[month], transparency);
      //println(city.cityName +" " + city.year+" "+city.temperatures[month]);
      drawMonth(city.coord, month, offsetAngle + month * PI * 7 / 8, radiusOffset);
    }
  }
}
