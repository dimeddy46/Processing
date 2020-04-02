class Shape 
{
    float posX, posY; 
    int size;
    
    Shape(float x, float y, int size) 
    {
        posX = x;
        posY = y;
        this.size = size;
        
        lines.add(new Line(x, y, x+size, y));
        lines.add(new Line(x+size, y, x+size, y+size));
        lines.add(new Line(x+size, y+size, x, y+size));
        lines.add(new Line(x, y+size, x, y));
    }  
    
    void drawObject() 
    {
        fill(0, 255, 255);
        rect(posX, posY, size, size);
    }    
}

class Line
{
    float x3, y3, x4, y4;
    
    Line(float x3, float y3, float x4, float y4) 
    {
        this.x3 = x3; this.y3 = y3;
        this.x4 = x4; this.y4 = y4;
    }   
}
