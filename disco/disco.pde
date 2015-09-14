// disco ball
// approximated sphere, axis on Z

final int Ntheta = 20;
final int Nphi = 20;
final int r = 10;

void setup() {
 size(640, 480, P3D); 
}

void draw() {
  for(int i=0; i < Ntheta; i++) {
    for(int j=0; j < Nphi; j++) {
      
      if (i == 0 || i == (Ntheta - 1)) {
        beginShape(TRIANGLE_FAN);
        
      }
      else {
        beginShape(TRIANGLE_STRIP);
      }  
    }
  }
}
