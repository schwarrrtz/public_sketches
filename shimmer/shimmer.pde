PShape map;
PShader water;

final int size_x = 1000;
final int size_y = 700;
float time = 0.0;

void setup()
{
  size(size_x, size_y, P2D);
  map = loadShape("inkscape_test.svg");
  water = loadShader("water_frag.glsl", "water_vert.glsl");
  water.set("scale", 1.5);
}

void draw()
{
  background(0);
  water.set("time", time);
  time += 0.05;
  shader(water);
  
  map.disableStyle();
  fill(0);
  stroke(255);
  shape(map, 0, 0, size_x, size_y);
  
  println(frameRate);
  saveFrame();
}
