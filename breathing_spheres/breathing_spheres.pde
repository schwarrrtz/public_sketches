int Ntheta = 50;
int Nphi = 100;
float t = 0;

void setup() {
  size(1280, 720, P3D);
  camera(0, 0, -400, float(width)/2, float(height)/2, 0, 0, 1, 0);
  perspective(PI/3, float(width)/float(height), -290, 300);
  frameRate(30);
}

void draw() {
  background(200);
  drawSphere(sinWave(0, 100, 200), width/2 + 400, height/2, 0);
  drawSphere(sinWave(PI, 100, 200), width/2 + 100, height/2 - 59, -50);
  drawSphere(sinWave(PI/3, 100, 200), width/2 - 300, height/2 + 323, 33);
  t += 0.001; t %= 1.0;
}

void drawSphere(float r, float x, float y, float z) {
    for(float theta = 0; theta <= PI; theta += PI/Ntheta) {
    for(float phi = -1*PI; phi <= PI; phi += 2*PI/Nphi) {
      float Px = sin(theta)*cos(phi)*r;
      float Pz = sin(theta)*sin(phi)*r;
      float Py = cos(theta)*r;
      point(x + Px, y + Py, z + Pz);  
    }
  }
}

float sinWave(float phase, float min, float max) {
  return (max-min)/2*sin(2*PI*t + phase) + (max-min)/2 + min;
}
