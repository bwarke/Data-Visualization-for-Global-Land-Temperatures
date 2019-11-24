class City { //creating cities and adding data and attributes to each city for every year
  Coord coord;
  float[] temperatures = new float[13];
  int id;
  String cityName;
  String countryName;
  float offsetAngle;
  int year;
  Oscillation oscillation;
  City (Coord coord, float[] temperatures, int id, String cityName, String countryName, Oscillation oscillation, int year) {
    this.coord = coord;
    this.temperatures[0] = 0.0f;
    for (int i = 1; i<13; i++)
      this.temperatures[i] = temperatures[i];

    this.id = id;
    this.cityName = cityName;
    this.countryName = countryName;
    this.oscillation = oscillation;
    this.year = year;
  }
}
