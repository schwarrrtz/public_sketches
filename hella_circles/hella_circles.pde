// david schwartz
// 10 october 2014
// fuck complex analysis    

Circle[] circles;
final int numCircles = 5000;
boolean makeMoreCircles = true;

void setup()
{
  size(1280, 720, P2D);
  background(255);
  initializeCircleClass();
  
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
    if((circles[i].offscreen) && makeMoreCircles)
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

void mouseClicked()
{
  makeMoreCircles = !makeMoreCircles;
}

// Circle 'class'
final float rMin = 10;
final float rMax = 30;
final float vMin = 3;  
final float vMax = 6;
final float border = 50;  // defines region where shapes are valid
final int numShapes = 20;
PShape[] shapes = new PShape[numShapes];
float[] radii = new float[numShapes];
    
void initializeCircleClass()
{
  for(int i=0; i < numShapes; i++)   
  {
    float r = random(rMin, rMax);
    radii[i] = r;
    shapes[i] = createShape(ELLIPSE, 0, 0, r, r);
  }
}  

class Circle
{ 
  // instance variables
  float x, y;
  int index;
  PVector v;
  boolean offscreen = false;
  
  // instance methods
  Circle()
  {
    x = random(-border, width);
    y = random(-border, height);
    index = floor(random(0, numShapes));
    float vX = random(vMin, vMax);
    float vY = random(vMin, vMax);
    float coinX = random(0, 1);
    float coinY = random(0, 1);
    if(coinX > 0.5)
    {
      vX *= -1;
    }
    if(coinY > 0.5)
    {
      vY *= -1;
    }
    v = new PVector(vX, vY);
  }
  
  void update()
  {
    x += v.x;
    y += v.y;
    
    if (((x-radii[index]) > width) || ((x+radii[index]) < -border) || ((y-radii[index]) > height) || ((y+radii[index]) < -border))
    {
      offscreen = true;
    }
  }
  
  void render()
  {
     shape(shapes[index], x, y);
  }
}
