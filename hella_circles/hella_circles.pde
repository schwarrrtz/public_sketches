// david schwartz
// 10 october 2014
// fuck complex analysis    

Circle[] circles;
final int numCircles = 1000;

void setup()
{
  size(1280, 720);
  background(255);
  
  circles = new Circle[numCircles];
  for(int i = 0; i < numCircles; i++)
  {
    circles[i] = new Circle();
  }
}

void draw()
{
  for(int i = 0; i < numCircles; i++)
  {
    circles[i].update();
    if(circles[i].offscreen)
    {
      circles[i] = new Circle();
    }
    circles[i].render();
  }
  
  if ((frameCount % 50) == 0)
  {
    println("frame rate:" + frameRate);
  }
}

// Circle constants
final int rMin = 10;
final int rMax = 30;
final int vMin = -5;
final int vMax = 5;
final int border = 50;

class Circle
{
  float x, y, r;
  PVector v;
  boolean offscreen = false;
  
  Circle()
  {
    x = random(-border, width);
    y = random(-border, height);
    r = random(rMin, rMax);
    v = new PVector(random(vMin, vMax), random(vMin, vMax));
  }
  
  void update()
  {
    x += v.x;
    y += v.y;
    
    if (((x-r) > width) || ((x+r) < -border) || ((y-r) > height) || ((y+r) < -border))
    {
      offscreen = true;
    }
  }
  
  void render()
  {
    if(!offscreen)
    {
      ellipse(x, y, r, r);
    }
  }
}
