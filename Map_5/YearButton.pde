class YearButton { // creating buttons to allow the user to select a button
  int xLoc, yLoc;
  int year;
  boolean isSelected = false;
  
  YearButton(int xLoc, int yLoc, int year){
    this.xLoc = xLoc;
    this.yLoc = yLoc;
    this.year = year;
  }
void drawYearButton (){
  stroke(220);
  strokeWeight(2);
  fill(10);
  rect(xLoc, yLoc, 100, 50);
  textSize(18);
  fill(255);
  textAlign(CENTER);
  text(year, xLoc+50, yLoc+32);
 }
 
void selectButton (){
  stroke(220);
  fill(220);
  rect(xLoc, yLoc, 100, 50);
  textSize(25);
  fill(0);
  textAlign(CENTER);
  text(year, xLoc+50, yLoc+35);
 }
 boolean selected(){
   isSelected = false;
   if( (xLoc < mouseX ) && (mouseX < xLoc+100) && (yLoc < mouseY) && (mouseY < yLoc+50))
   {
     isSelected = true;
   }
   
   return isSelected;
 }
}
