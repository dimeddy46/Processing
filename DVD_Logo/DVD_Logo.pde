Obj[] objects = new Obj[] { 
  new Obj(3, 50), new Obj(3, 50),new Obj(3, 50),new Obj(3, 50),new Obj(3, 50),new Obj(3, 50),new Obj(3, 50), new Obj(3, 50)
};

void setup() {
  size(1400, 900);
  frameRate(75);
}

class Obj {
    public int speed, size, state, speedDir;
    public float x, y, r, g, b;

    Obj(int speed, int size)
    {
      this.speed = speed;
      this.speedDir = 0;
      this.size = size;
      
      this.r = random(255);
      this.g = random(255);
      this.b = random(255);
      
      this.x = random(10) * random(width - size);
      this.y = random(10) * random(height - size);
      this.state = (int)random(4);
      
    }
    
    void Execute(){
       moveObj();
       state = changeState();
    }
    
    void moveObj()
    {
        switch(state) 
        {
          case 0:
            x += speed; y += speed; break;
          case 1:
            x += speed; y -= speed; break;
          case 2:
            x -= speed; y -= speed; break;
          case 3:
            x -= speed; y += speed; break;
        }
    }
        
    int changeState()
    {
        if (y >= height-size) 
        {
          changeColor();
          if (state == 0) return 1;
          return 2;
        }
      
        if (x >= width-size)
        {
          changeColor();
          if (state == 1) return 2;
          return 3;
        }
      
        if (y <= 0) 
        {
          changeColor();
          if (state == 2) return 3;
          return 0;
        }
      
        if (x <= 0)
        {
          changeColor();
          if (state == 3) return 0;
          return 1;
        }
        
        return state;
    }
    
    void changeColor() 
    {
        if(speedDir == 0){
          speed = random(10) > 5 ? speed+1 : speed;
          if(speed > 11) speedDir = 1;
        }
        else if(speedDir == 1){
          speed = random(10) > 5 ? speed-1 : speed;
          if(speed <= 2) speedDir = 0;
        }
    }
}


void draw() {
  background(255);
  for(int i = 0; i<objects.length;i++)
  {
      rect(objects[i].x, objects[i].y, objects[i].size, objects[i].size);
      fill(objects[i].r, objects[i].g, objects[i].b);
      objects[i].Execute();
  }
}

void keyTyped() {
}
