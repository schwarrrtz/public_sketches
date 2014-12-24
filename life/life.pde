// game of life
// originally by conway. this implementation by david schwartz
// 17 december 2014

// size of grid
final int Nx = 80;
final int Ny = 50;

// size of cell (for drawing)
final float cellWidth = 20;
final float cellHeight = 20;

// double buffered grid
Cell[][] gridA = new Cell[Nx][Ny];
Cell[][] gridB = new Cell[Nx][Ny];
boolean usingGridA = false;

// for obvious purposes
boolean paused = true;

class Cell
{
  PVector origin, size;
  boolean isAlive;  
  
  Cell(PVector _origin, PVector _size)
  {
     origin = _origin;
     size = _size;
     isAlive = false;
  }
}

void setup()
{
  size((int)cellWidth*Nx, (int)cellHeight*Ny);
  frameRate(30);
  
  for(int yIndex = 0; yIndex < Ny; yIndex++)
  {
     for(int xIndex=0; xIndex < Nx; xIndex++)
     {
       PVector origin = new PVector(xIndex*cellWidth, yIndex*cellHeight);
       PVector size = new PVector(cellWidth, cellHeight);
       gridA[xIndex][yIndex] = new Cell(origin, size);
       gridB[xIndex][yIndex] = new Cell(origin, size);
     }
  }     
}

void draw()
{  
  // update at 2Hz. framerate is 30Hz
  if(!paused && (frameCount % 15 == 0))
  {
    Cell[][] oldGrid, newGrid;
        
    if(usingGridA)
    {
      oldGrid = gridA;
      newGrid = gridB;
    }
    else
    {
      oldGrid = gridB;
      newGrid = gridA;
    }
    usingGridA = !usingGridA;
    
    for(int xIndex = 0; xIndex < Nx; xIndex++)
    {
      for(int yIndex = 0; yIndex < Ny; yIndex++)
      {
        int[] xNeighbor = { xIndex - 1, xIndex, xIndex + 1,
                            xIndex - 1,         xIndex + 1,
                            xIndex - 1, xIndex, xIndex + 1 };
        int[] yNeighbor = { yIndex - 1, yIndex - 1, yIndex -1,
                            yIndex,                 yIndex,
                            yIndex + 1, yIndex + 1, yIndex + 1 };
        
        int aliveNeighbors = 0;
        
        for(int i = 0; i < 8; i++)
        {
          if((xNeighbor[i] >= 0) && (yNeighbor[i] >= 0) && (xNeighbor[i] < Nx) && (yNeighbor[i] < Ny))
          {
            if(oldGrid[xNeighbor[i]][yNeighbor[i]].isAlive)
            {
              aliveNeighbors++;
            }
          }
        }
        
        // birth
        if(!oldGrid[xIndex][yIndex].isAlive)
        {
          newGrid[xIndex][yIndex].isAlive = (aliveNeighbors == 3);
        }
        
        // death
        else
        {
          // crowding
          if(aliveNeighbors >= 4)
            newGrid[xIndex][yIndex].isAlive = false;
            
          // exposure
          else if(aliveNeighbors <= 1)
            newGrid[xIndex][yIndex].isAlive = false;
            
          // survival
          else
            newGrid[xIndex][yIndex].isAlive = true;
        }
      }
    }
  }
  
  // always draw the cells, even when paused
  for(int xIndex = 0; xIndex < Nx; xIndex++)
  {
    for(int yIndex = 0; yIndex < Ny; yIndex++)
    {
      Cell c;
      if(usingGridA)
        c = gridA[xIndex][yIndex];
      else
        c = gridB[xIndex][yIndex];
      
      if(c.isAlive)
        fill(255);
      else
        fill(80);
        
      rect(c.origin.x, c.origin.y, c.size.x, c.size.y);
    }
  }
}

void keyPressed()
{
  paused = !paused;
}

void mouseReleased()
{
  int xIndex = floor(mouseX / cellWidth);
  int yIndex = floor(mouseY / cellHeight);
  
  if(usingGridA)
    gridA[xIndex][yIndex].isAlive = !gridA[xIndex][yIndex].isAlive;
  else
    gridB[xIndex][yIndex].isAlive = !gridB[xIndex][yIndex].isAlive;
}
  
  
