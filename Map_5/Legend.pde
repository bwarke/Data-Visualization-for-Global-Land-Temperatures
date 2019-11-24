class Legend { // legend to show correlation between colors and temperatures
  int xPos, yPos;
  color[] colors = {color(152, 122, 184), color(121, 152, 208), color(122,202,193), color(145, 210, 95),  color(253, 255, 122), color(253, 182, 140), color(254, 125, 130),color(228, 141, 184)}; 
  
  //Legend (int xPos, int yPos){
  //this.xPos = xPos;
  //this.yPos = yPos;
  //}
void drawLegend (int xPos, int yPos){
  fill(255);
  textSize(20);
  textAlign(LEFT);
  text("Temperature Legend:", xPos-35, yPos-15);
  int _temp = -20;
  for (int i =0; i<8; i++){
  noStroke();
  fill(colors[i]);
  rect (xPos-18, yPos, 35, 35);
  textSize(12);
  textAlign(CENTER);
  if (_temp==-20){
    text("<" + _temp + "degC", xPos, yPos+50);
  } 
  else if(_temp>40){
    text(">" + (_temp-10) + "degC", xPos, yPos+ 50);
  }
  else {
  text ((_temp-10) + " degC \n to \n" + (_temp) + " degC", xPos, yPos+50);
  }
  //println(_temp, xPos, yPos);
  _temp = _temp+10;
  xPos =xPos+60;
  }
 }
}
