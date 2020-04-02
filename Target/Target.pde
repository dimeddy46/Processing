int speed = 2, playerSize = 20;
float x1, y1, x2, y2;
boolean[] keys = new boolean[4];
ArrayList<Line> lines = new ArrayList<Line>();

Shape[] shapes = new Shape[] 
{
      new Shape(200, 300, 50), 
      new Shape(600, 600, 50), 
      new Shape(100, 700, 70),
      new Shape(900, 200, 100),
};
void setup() 
{     
     frameRate(120);
     size(1200, 800);
     x1 = width / 2;
     y1 = height / 2;
}

void draw()
{
    background(200);
    x2 = mouseX;
    y2 = mouseY;   
    drawShapes();
    calculateCollision();
    setMouseTarget();
    movePlayer();  
}

void setMouseTarget()
{  
    fill(0, 255, 0);  
    circle(x2, y2, 5);
    line(x1+playerSize / 2, y1+playerSize / 2, x2, y2); 
}

boolean isCollinear(float px1, float py1, float midx, float midy, float px2, float py2)
{
     if( (min(px1, px2) <= midx && midx <= max(px1, px2)) && (min(py1, py2) <= midy && midy <= max(py1, py2)) )
         return true;
     return false;
}

void calculateCollision()
{
    float rezX, rezY, finalX = -5, finalY = -5;
    float distPlayer = 0, closestCollision = width * 2;

    for(int i = 0;i < lines.size();i++)
    {
        rezX = ((x1 * y2 - y1 * x2) * (lines.get(i).x3 - lines.get(i).x4) - (x1 - x2) * (lines.get(i).x3 * lines.get(i).y4 - lines.get(i).y3 * lines.get(i).x4)) /
                             ((x1 - x2) * (lines.get(i).y3 - lines.get(i).y4) - (y1 - y2) * (lines.get(i).x3 - lines.get(i).x4));
                                    
        rezY = ((x1 * y2 - y1 * x2) * (lines.get(i).y3 - lines.get(i).y4) - (y1 - y2) * (lines.get(i).x3 * lines.get(i).y4 - lines.get(i).y3 * lines.get(i).x4)) / 
                             ((x1 - x2) * (lines.get(i).y3 - lines.get(i).y4) - (y1 - y2) * (lines.get(i).x3 - lines.get(i).x4));
        
        if (isCollinear(lines.get(i).x3, lines.get(i).y3, rezX, rezY, lines.get(i).x4, lines.get(i).y4))
        {           
              distPlayer = dist(x1, y1, rezX, rezY);
              if(distPlayer < closestCollision && isCollinear(x1, y1, rezX, rezY, x2, y2))
              { 
                  finalX = rezX; 
                  finalY = rezY; 
                  closestCollision = distPlayer; 
              }
        }
    }
    
    if(finalX != -5 && finalY != -5) {
        x2 = finalX; y2 = finalY;
       // circle(finalX+2, finalY, 5);
    }
}

void drawShapes() 
{
    for(int i = 0;i < shapes.length; ++i)
    {
        shapes[i].drawObject();
    }
}

void movePlayer()
{
    if(keys[0]) y1 -= speed;
    if(keys[1]) y1 += speed;
    if(keys[2]) x1 -= speed;
    if(keys[3]) x1 += speed;
    
    fill(255, 0, 0);
    rect(x1, y1, playerSize, playerSize);
}

void keyPressed() 
{ 
    switch(key) 
    {
       case 'w' : keys[0] = true; break;
       case 's' : keys[1] = true; break;
       case 'a' : keys[2] = true; break;
       case 'd' : keys[3] = true; break;
    }
}

void keyReleased() 
{
    switch(key) 
    {
       case 'w' : keys[0] = false; break;
       case 's' : keys[1] = false; break;
       case 'a' : keys[2] = false; break;
       case 'd' : keys[3] = false; break;
    }
}
