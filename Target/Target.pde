int speed = 2, playerSize = 15;
float x1, y1, x2, y2, viewArea = 30.0;
boolean[] keys = new boolean[4];
ArrayList<Line> lines = new ArrayList<Line>();

Shape[] shapes = new Shape[] 
{
      new Shape(200, 300, 50), 
      new Shape(600, 600, 50), 
      new Shape(100, 700, 70),
      new Shape(900, 200, 100),
      new Shape(1000, 400, 100),
      new Shape(400, 300, 100),
      new Shape(600, 200, 100),
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
    float pX = x1+playerSize / 2, pY = y1+playerSize / 2;
    float projX = pX-((x2 - pX) * pY) / (y2 - pY);
    float projY = pY-((y2 - pY) * pX) / (x2 - pX);
    float finalX, finalY;
    
    if(projX < 0 || projX > width)
    {
        if(x2 - pX < 0) 
        { 
            finalX = 5; finalY = projY;
        }
        else 
        {
            finalX = width-5; finalY = height-projY;
        }
    }
    else 
    {
        if(y2 - y1 < 0) 
        { 
            finalX = projX; finalY = 5;
        }
        else 
        { 
            finalX = width-projX;  finalY = height-5; 
        } 
    }
    
    fill(255, 0, 0);  
    circle(x2, y2, 5);    
    line(pX, pY, x2, y2);
    circle(finalX, finalY, 10);
    
    println(pX+" "+pY+" | "+x2+" "+y2+" | "+((y2-pY)/(x2-pX)) +" | "+projX +" "+projY +" | ");
}

boolean isCollinear(float px1, float py1, float midx, float midy, float px2, float py2)
{
     if( (min(px1, px2) <= midx && midx <= max(px1, px2)) && (min(py1, py2) <= midy && midy <= max(py1, py2)) )
         return true;
     return false;
}

void calculateCollision()
{
    float rezX, rezY, finalX = 0, finalY = 0;
    float distPlayerToTarget = 0, closestCollision = width * 2;
    
    for(int i = 0;i < lines.size();i++)
    {
        float x3 = lines.get(i).x3, y3 = lines.get(i).y3, x4 = lines.get(i).x4, y4 = lines.get(i).y4;
        
        rezX = ((x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4)) /
                         ((x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4));
                                    
        rezY = ((x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4)) / 
                         ((x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4));
        
        if (isCollinear(x3, y3, rezX, rezY, x4, y4))
        {           
              distPlayerToTarget = dist(x1, y1, rezX, rezY);
              if(distPlayerToTarget < closestCollision && isCollinear(x1, y1, rezX, rezY, x2, y2))
              { 
                  finalX = rezX; 
                  finalY = rezY; 
                  closestCollision = distPlayerToTarget; 
              }
        }
    }
    
    if(finalX != 0 && finalY != 0) 
    {
        x2 = finalX; y2 = finalY;
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
