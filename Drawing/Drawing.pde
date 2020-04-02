int winX, winY, lastX, lastY, x, y, size, dir = 2 ,r;

void setup() {
  frameRate(1000);
  background(255);
  size(1400,900);
  
  x = 400;
  y = 300;
  size = 20;
  r = 254;
  
  //lastX = getJFrame(getSurface()).getX();
  //lastY = getJFrame(getSurface()).getY();
}

void windowMove(){
  int xCalc = abs(lastX - winX), yCalc = abs(lastY - winY);
  if(lastX < winX) // dr
    x += xCalc;
  else 
    x -= xCalc;
   
  if(lastY < winY) // sus
    y += yCalc;
  else 
    y -= yCalc;
    
  lastX = winX;
  lastY = winY;   
}

void react()
{
    if(r >= 255) dir = 2;
    else if(r <= 50) dir = -2;
    r -= dir;
}

void draw(){
  //winX = getJFrame(getSurface()).getX();
  //winY = getJFrame(getSurface()).getY();
  react();
  if(mousePressed == true && mouseButton == LEFT){
     x = mouseX-size/2;
     y = mouseY-size/2;  
  }
  
  rect(x, y, size, size);
  fill(r, 255-r, 0);  
}
 
static final javax.swing.JFrame getJFrame(final PSurface surf) {
  return (javax.swing.JFrame) ((processing.awt.PSurfaceAWT.SmoothCanvas)  surf.getNative()).getFrame();
}

void mouseClicked(){
  if(mouseButton == RIGHT)
    background(255);
}
