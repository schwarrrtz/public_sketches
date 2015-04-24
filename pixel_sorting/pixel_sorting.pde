
PImage img;
String imgFile; // assign to image file name

void setup() {
  img = loadImage(imgFile);
  size(img.width, img.height);
  
  img.loadPixels();
  
  for(int i=0; i < img.height; i++) {
    color[] unsorted = getRow(i);
    color[] sorted = sort(unsorted);
    setRow(i, sorted);
  }
  
  for(int i=0; i < img.width; i++) {
    color[] unsorted = getColumn(i);
    color[] sorted = sort(unsorted);
    setColumn(i, sorted);
  }
  
  img.updatePixels();
  image(img, 0, 0);
  
  //saveFrame("sorted.png");
}

void draw() {
  
}

void setColumn(int x, color[] newColumn) {
  for(int i=0; i<img.height; i++) {
    img.pixels[x + i*img.width] = newColumn[img.height -1 - i];
  }
}

color[] getColumn(int x) {
  color[] column = new color[img.height];
  for(int i=0; i<img.height; i++) {
    column[i] = img.pixels[x + i*img.width];
  }
  return column;
}

void setRow(int y, color[] newRow) {
  for(int i=0; i<img.width; i++) {
    img.pixels[i + y*img.width] = newRow[i];
  }
}

color[] getRow(int y) {
  color[] row = new color[img.width];
  for(int i=0; i<img.width; i++) {
    row[i] = img.pixels[i + y*img.width];
  }
  return row;
}
  
