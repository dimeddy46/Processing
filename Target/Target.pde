int speed = 2, playerSize = 15, targetSz = 10;
float x1, y1, pX, pY, x2, y2, viewArea = 30.0, finalX, finalY;
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
    drawShapes();
    movePlayer();  
    x2 = mouseX;
    y2 = mouseY;  
    
    setMouseProjection();
    
    float[] collision = computeCollision(); 
    if(collision[0] != -1)
    { 
        finalX = collision[0];
        finalY = collision[1];
    }
    
    fill(255, 0, 0);
    circle(finalX, finalY, 20);
    line(pX, pY, finalX, finalY);
}

boolean isValidTarget(float x, float max)
{
   return x >= targetSz && max-targetSz >= x;
}

void setMouseProjection()
{   
    float slope = (y2 - pY) / (x2 - pX);   
    float projX = (targetSz + slope * pX - pY) / slope; 
    float projY = slope * targetSz - slope*pX + pY;
    float testX = (height + slope * pX - pY) / slope;
    float testY = slope * width - slope*pX + pY;

    if(y2 - pY > 0 && isValidTarget(testX, width))   // jos
    {
        finalX = testX; 
        finalY = height-targetSz;
    } 
    
    if(x2 - pX > 0 && isValidTarget(testY, height))  // dreapta 
    {
        finalX = width-targetSz; 
        finalY = testY;
    }
    
    if(y2 - pY < 0 && isValidTarget(projX, width))   // sus
    {
        finalX = projX; 
        finalY = targetSz;
    }  
    
    if(x2 - pX < 0 && isValidTarget(projY, height))  // stanga
    {
        finalX = targetSz; 
        finalY = projY;
    }  

    //println(pX+" "+pY+" | "+x2+" "+y2+" | "+slope+" | "+projX +" "+projY +" | "+testX+" "+testY+ " | ");
}

boolean isCollinear(float px1, float py1, float midx, float midy, float px2, float py2)
{
     if( (min(px1, px2) <= midx && midx <= max(px1, px2)) && (min(py1, py2) <= midy && midy <= max(py1, py2)) )
         return true;
     return false;
}

float[] computeCollision()
{   
    float rezX, rezY, finX = -1, finY = -1;
    float distPlayerToTarget = 0, closestCollision = width * 2;
    
    for(int i = 0;i < lines.size();i++)
    {
        float x3 = lines.get(i).x3, y3 = lines.get(i).y3, x4 = lines.get(i).x4, y4 = lines.get(i).y4;
        
        rezX = ((pX * y2 - pY * x2) * (x3 - x4) - (pX - x2) * (x3 * y4 - y3 * x4)) /
                         ((pX - x2) * (y3 - y4) - (pY - y2) * (x3 - x4));
                                    
        rezY = ((pX * y2 - pY * x2) * (y3 - y4) - (pY - y2) * (x3 * y4 - y3 * x4)) / 
                         ((pX - x2) * (y3 - y4) - (pY - y2) * (x3 - x4));
        
        if (isCollinear(x3, y3, rezX, rezY, x4, y4))
        {           
              distPlayerToTarget = dist(pX, pY, rezX, rezY);
              if(distPlayerToTarget < closestCollision && isCollinear(pX, pY, rezX, rezY, finalX, finalY))
              { 
                  finX = rezX; 
                  finY = rezY; 
                  closestCollision = distPlayerToTarget; 
              }
        }
    }
        
    return new float[] {finX, finY};
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
    
    pX = x1+playerSize / 2; 
    pY = y1+playerSize / 2;    
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
