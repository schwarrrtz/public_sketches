// agent-based camera experiment
// david schwartz
// 15 feb 2015

import processing.video.*;
Capture camera;

class Agent
{
  float x,y;
  color c;
  
  Agent(float _x, float _y)
  {
    x = _x;
    y = _y; 
    c = color(0, 0, 0);
  }
  
  void update()
  {
    c = camera.get(int(x + random(-15, 15)), int(y + random(-15, 15)));
    x += random(2, 5); x %= width;
    y += random(2, 5); y %= height;
  }
  
  void display()
  {
    fill(c);
    ellipse(x, y, 5, 5);
  }
}

Agent[] agents = new Agent[1000];

void setup()
{
  size(1280,720);
  
  for(int i=0; i < agents.length; i++)
  {
    agents[i] = new Agent(random(width), random(height));
  }
  
  String[] cameras = Capture.list();
  for(int i=0; i < cameras.length; i++)
  {
    println(cameras[i]);
  }
  
  camera = new Capture(this, cameras[0]);
  camera.start();
}

void draw()
{
  if(camera.available())
  {
    camera.read();
  }
  
  for(int i=0; i < agents.length; i++)
  {
    agents[i].update();
    agents[i].display();
  }
}
