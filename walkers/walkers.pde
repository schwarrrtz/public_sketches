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
    c = color(random(0.5, 0.75), 1.0, random(0.0, 1.0), 0.05);
  }
  
  void step()
  {
    float xInc = random(-0.5, 1.25);
    float yInc = random(-0.5, 1.25);
    x += xInc; y += yInc;
    
    x%=(width+100); y%=(height+100);
  }
  
  void display()
  {
    stroke(c);
    fill(c);
    ellipse(x,y,20,20);
  }
}

Walker[] w = new Walker[800];

void setup()
{
  size(1280, 720);
  background(0);
  colorMode(HSB, 1.0);
  //frameRate(10000);
  
  for(int i=0; i < w.length; i++)
  {
    w[i] = new Walker(random(width), random(height));
  }
  
  for(int j=0; j < 300; j++)
  {
    for(int i=0; i < w.length; i++)
    {
      w[i].step();
      w[i].display();
    }
  }
}

void draw()
{
  for(int i=0; i < w.length; i++)
  {
    w[i].step();
    w[i].display();
  }
  
  println(frameRate);
}

void keyPressed()
{
  saveFrame("walkers-########.png");
}
