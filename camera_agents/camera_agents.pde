// agent-based camera experiment
// david schwartz
// 15 feb 2015

import processing.video.*;
import controlP5.*;

Capture camera;
ControlP5 cp5;

int blurX = 15;  Knob knobBlurX;
int blurY = 15;  Knob knobBlurY;
int speedX = 2;  Knob knobSpeedX;
int speedY = 5;  Knob knobSpeedY;
int sizeX = 5;   Knob knobSizeX;
int sizeY = 5;   Knob knobSizeY;
int alpha = 255; Knob knobAlpha;

class Agent
{
  float x,y;
  color c;
  
  Agent(float _x, float _y) {
    x = _x;
    y = _y; 
    c = color(0, 0, 0);
  }
  
  void update() {
    c = camera.get(int(x + random(-1*blurX, blurX)), int(y + random(-1*blurY, blurY)));
    x += random(speedX, pow(speedX,2)); x %= width;
    y += random(speedY, pow(speedY,2)); y %= height;
  }
  
  void display() {
    fill(c, alpha);
    stroke(c, alpha);
    ellipse(x, y, sizeX, sizeY);
  }
}

Agent[] agents = new Agent[1000];

void setup()
{
  size(1280,720);
  cp5 = new ControlP5(this);
  
  knobBlurX = createDefaultKnob("blurX").setRange(0,100).setValue(blurX).setPosition(10,10);
  knobBlurY = createDefaultKnob("blurY").setRange(0,100).setValue(blurY).setPosition(70,10);
  knobSpeedX = createDefaultKnob("speedX").setRange(0,20).setValue(speedX).setPosition(130,10);
  knobSpeedY = createDefaultKnob("speedY").setRange(0,20).setValue(speedY).setPosition(190,10);
  knobSizeX = createDefaultKnob("sizeX").setRange(0,100).setValue(sizeX).setPosition(250,10);
  knobSizeY = createDefaultKnob("sizeY").setRange(0,100).setValue(sizeY).setPosition(310,10);
  knobAlpha = createDefaultKnob("alpha").setRange(0,255).setValue(alpha).setPosition(370,10);
  
  for(int i=0; i < agents.length; i++) {
    agents[i] = new Agent(random(width), random(height));
  }
  
  String[] cameras = Capture.list();
  for(int i=0; i < cameras.length; i++) {
    println(cameras[i]);
  }
  
  camera = new Capture(this, cameras[0]);
  camera.start();
}

void draw()
{
  if(camera.available()) {
    camera.read();
  }
  
  for(int i=0; i < agents.length; i++) {
    agents[i].update();
    agents[i].display();
  }
}

Knob createDefaultKnob(String knobName)
{
  return cp5.addKnob(knobName).setRadius(20).setNumberOfTickMarks(10).setTickMarkLength(2)
         .snapToTickMarks(false).setColorForeground(color(255)).setColorBackground(color(50))
         .setColorActive(color(150)).setDragDirection(Knob.HORIZONTAL);
} 
