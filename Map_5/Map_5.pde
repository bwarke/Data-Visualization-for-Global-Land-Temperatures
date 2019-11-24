PShape sMap;  //PShape with the world map
PGraphics pgMap, pgOcean, pgLand;

Table[] data = new Table[3]; //for the 3 years that we have data for
float oscillationRange;

//booleans for interactive elements
boolean[] activeCities;
boolean anyActive;
boolean[] activeButton;

int mapCenterX, mapCenterY;
int yearIndex;

// All cities
City[][] cities;
CityArcs cityArcs = new CityArcs();

//Temperature legend
Legend legend = new Legend();
YearButton[] yearButton = new YearButton[3];

//colors
color ocean = color(0, 0, 0);  //light blue
color land = color(50, 50, 50);  //light green
color snow = color(35);  //white


/*-----------------------*/


void setup()
{
  size(1280, 1024);

  loadMap();
  createLand();
  createOceans();
  //get data for cities from .csv file

  yearIndex = 0;//default year
  mapCenterX = (width-25)/2;
  mapCenterY = height/2;
  yearButton[0] = new YearButton(800, 850, 2012);
  yearButton[1] = new YearButton(940, 850, 1962);
  yearButton[2] = new YearButton(1080, 850, 1912);

  fetchData();
  yearButton[0].isSelected = true;




  // println(cities[i].cityName + " (" + cities[i].countryName + ") has an ID of " + cities[i].id + " and temp in January 2012 was " + cities[i].temperatures[1]);
  //println(cities[i].coord.x + ", " + cities[i].coord.y);
}


/*-----------------------*/


void draw()
{
  image(pgLand, 0, 0);
  image(pgOcean, 0, 0);
  legend.drawLegend(100, 850); //drawing temperature legend

  pushMatrix(); // write drawing codes after this

  translate (mapCenterX, mapCenterY); //to map city locations using latitudes and longitudes
   //draw markers at every city and draw Arcs representing 12 months of Temperature data
  for (int i=0; i<cities[yearIndex].length; i++) {
    cities[yearIndex][i].coord.drawMapPoint();


  //if any city is selected, the arcs for it become bigger and brighter and the data for other cities dim down. You can select/deselect multiple cities by clicking on them.
    if (anyActive) {
      if (activeCities[i]) {
        cityArcs.drawArcs(cities[yearIndex][i], cityArcs.BRIGHT_TRANSPARENCY, 5);
      } else if (dist(mouseX - mapCenterX, mouseY - mapCenterY, cities[yearIndex][i].coord.x, cities[yearIndex][i].coord.y) < 30) {
        cityArcs.drawArcs(cities[yearIndex][i], cityArcs.DIM_TRANSPARENCY, 5);
        
      } else {
        cityArcs.drawArcs(cities[yearIndex][i], cities[yearIndex][i].oscillation.oscillate(), cityArcs.DIM_TRANSPARENCY, 0);
      }
    }
    // no active
    else {
      if (dist(mouseX - mapCenterX, mouseY - mapCenterY, cities[yearIndex][i].coord.x, cities[yearIndex][i].coord.y) < 30) {
        cityArcs.drawArcs(cities[yearIndex][i], cityArcs.REGULAR_TRANSPARENCY, 5);
        textAlign(CENTER);
        textSize(14);
        fill(255);
        text(cities[yearIndex][i].cityName + "(" + cities[yearIndex][i].countryName + ")", cities[yearIndex][i].coord.x, (cities[yearIndex][i].coord.y - 75));
      } else {
        cityArcs.drawArcs(cities[yearIndex][i], cities[yearIndex][i].oscillation.oscillate(), cityArcs.REGULAR_TRANSPARENCY, 0);
      }
    }
  
   if (dist(mouseX - mapCenterX, mouseY - mapCenterY, cities[yearIndex][i].coord.x, cities[yearIndex][i].coord.y) < 30) {
        textAlign(CENTER);
        textSize(14);
        fill(255);
        text(cities[yearIndex][i].cityName + "(" + cities[yearIndex][i].countryName + ")", cities[yearIndex][i].coord.x, (cities[yearIndex][i].coord.y - 75));
   }
}  

  popMatrix(); // write drawing codes before this

//select what year's data you would like to see
fill(255);
textSize(20);
textAlign(LEFT);
text("Data for Year:", 800, 835);
  for (int j=0; j<3; j++) {
    if (yearButton[j].isSelected || yearIndex == j) {
      yearButton[j].selectButton();
      yearIndex= j;
    } else {
      yearButton[j].drawYearButton();
      }
  }
fill(255);
textSize(26);
textAlign(CENTER);
text("Global Land Temperatures", 640, 50);  
  
}


//load map image
void loadMap()
{
  sMap = loadShape("worldRussiaSplitWithAntarcticaLow4.svg");  //load svg file
  sMap.disableStyle();  //disable style to be able to change the colors

  pgMap = createGraphics(width, height);  //create a PGraphic to draw the map
  pgMap.beginDraw();

  pgMap.background(255);

  pgMap.stroke(255);
  pgMap.fill(0);

  //draw twice with coordinates chosen to centralise the map
  pgMap.shape(sMap, 25, -80);
  pgMap.shape(sMap, 25 - width, -80);

  pgMap.endDraw();
}


/*-----------------------*/

void mouseClicked() {
  for (int i = 0; i < cities[yearIndex].length; i++) {
    if (dist(mouseX - mapCenterX, mouseY - mapCenterY, cities[yearIndex][i].coord.x, cities[yearIndex][i].coord.y) < 30) {
      activeCities[i] = !activeCities[i];
    }
  }
  boolean temp = false;
  for (int i = 0; i < activeCities.length; i++) {
    temp = temp || activeCities[i];
  }
  anyActive = temp;
  //println((mouseX - mapCenterX) + "," + (mouseY - mapCenterY) + ", anyActive: " + anyActive);
  // for loop checking year button & set the isSelected and de-select other's also chenge the yearIndex

  for (int j=0; j<3; j++) {
    yearButton[j].selected();
  }
}

/*-----------------------*/



void createLand()
{
  pgLand = createGraphics(width, height);

  pgLand.beginDraw();  
  //gadient color according to latitude
  for (int i = 0; i < pgLand.height/2; i++)
  {
    pgLand.stroke(lerpColor(land, snow, constrain(3.5*i/pgLand.height, 0, 1)));
    pgLand.line(0, pgLand.height/2 + i, pgLand.width, pgLand.height/2 + i);
    pgLand.line(0, pgLand.height/2 - i, pgLand.width, pgLand.height/2 - i);
  }   
  pgLand.endDraw();
}


/*-----------------------*/


void createOceans()
{
  pgOcean = createGraphics(width, height);

  pgOcean.beginDraw();
  pgOcean.loadPixels();
  pgMap.loadPixels();

  //use the map as a mask
  for (int i = 0; i < pgOcean.pixels.length; i++) 
    pgOcean.pixels[i] = color(ocean, pgMap.pixels[i] & 0xFF);

  pgOcean.updatePixels();
  pgOcean.endDraw();
}

/*-------------------------*/

//get data for the right years from the .csv files
void fetchData() {
  data[0] = loadTable("data2012.csv", "header");
  data[1] = loadTable("data1962.csv", "header");
  data[2] = loadTable("data1912.csv", "header");
  float[] temperatures = new float[13];
  int cityCount = data[0].getRowCount(); // since data for all years have the same num of cities 
  cities = new City[3][cityCount];

  for ( int year = 0; year <3; year++) {
    activeCities = new boolean[cityCount];

    oscillationRange = PI * 3 / 4;
    //println(cityCount + " total rows in table");
    //mapping data from columns to variables
    for (int i=0; i<cityCount; i++) {
      TableRow row = data[year].getRow(i);
      int id = row.getInt("id");
      String city = row.getString("City");
      String country = row.getString("Country");
      Coord coord = new Coord (row.getFloat("Lat"), row.getFloat("Lon"));
      Oscillation oscillation = new Oscillation(radians(random(0, 360)), oscillationRange);


      //initialize cities

      temperatures[0] = 0.0f;
      temperatures[1] = row.getFloat("Jan");
      temperatures[2] = row.getFloat("Feb");
      temperatures[3] = row.getFloat("Mar");
      temperatures[4] = row.getFloat("Apr");
      temperatures[5] = row.getFloat("May");
      temperatures[6] = row.getFloat("Jun");
      temperatures[7] = row.getFloat("Jul");
      temperatures[8] = row.getFloat("Aug");
      temperatures[9] = row.getFloat("Sep");
      temperatures[10] = row.getFloat("Oct");
      temperatures[11] = row.getFloat("Nov");
      temperatures[12] = row.getFloat("Dec");

      //creating cities
      cities[year][i] = new City (coord, temperatures, id, city, country, oscillation,year);
    }
  }
}
