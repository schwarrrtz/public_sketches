class Walker
{
  float x, y;
  color c;
  
  Walker()
  {
    x = width/2;
    y = height/2;
    c = color(random(1.0), 1.0, 1.0, 0.1);
  }
  
  Walker(float _x, float _y)
  {
    x = _x;
    y = _y;
    c = color(random(0.6, 0.7), random(1.0), random(1.0), 0.1);
  }
  
  void step()
  {
    float xInc = random(-1, 1);
    float yInc = random(-1, 1);
    x += xInc; y += yInc;
  }
  
  void display()
  {
    stroke(c);
    point(x,y);
  }
}

Walker[] w = new Walker[1000];

void setup()
{
  size(640, 480);
  background(255);
  colorMode(HSB, 1.0);
  frameRate(10000);
  
  for(int i=0; i < w.length; i++)
  {
    w[i] = new Walker(random(width), random(height));
  }
}

void draw()
{
  for(int i=0; i < w.length; i++)
  {
    w[i].step();
    w[i].display();
  }
}
