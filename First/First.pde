/*
A white cirle moves from the left edge of the screen
to the right edge of the screen. When it reaches the
right edge, it goes back to the left edge.
*/

float _cx = 0.0; //this is for x coordinate for circle --variable

void setup()
{
  size(800,600); // screen size
}

void draw()
{
  noStroke(); //get rid of the contour lines
  fill(0,0,0); // paint it black
  rect(0,0,width,height); 
  fill(255,255,255); //paint it white
  circle(_cx,height/2,40); //drawing the circle
  
  //it is a conditional execution
  if(_cx > width) //if the current position of the circle is...
  { 
    _cx = 0.0; 
  }
  else
  {
    _cx = _cx + 1;
  }
}
