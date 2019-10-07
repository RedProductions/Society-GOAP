class Grid{
  
  int sizeX, sizeY;
  
  int[][] grid;
  
  
  int dumpX, dumpY;
  int storX, storY;
  int entX, entY;
  
  
  
  Grid(){
    
    sizeX = GRID_RATIO;
    sizeY = height * GRID_RATIO / width;
    
    grid = new int[sizeX][sizeY];
    
    
  }
  
  
  
  boolean onDump(){
    if(entX == dumpX && entY == dumpY){
      return true;
    }
    return false;
  }
  
  boolean onStorage(){
    if(entX == storX && entY == storY){
      return true;
    }
    return false;
  }
  
  
  void setDump(int nx, int ny){
    
    dumpX = nx;
    dumpY = ny;
    
  }
  
  void setDump(float nx, float ny){
    
    int i = floor(nx * sizeX / width);
    int j = floor(ny * sizeY / height);
    
    dumpX = i;
    dumpY = j;
    
  }
  
  void setStorage(int nx, int ny){
    
    storX = nx;
    storY = ny;
    
  }
  
  
  void setStorage(float nx, float ny){
    
    int i = floor(nx * sizeX / width);
    int j = floor(ny * sizeY / height);
    
    storX = i;
    storY = j;
    
  }
  
  void setEntity(int nx, int ny){
    
    entX = nx;
    entY = ny;
    
  }
  
  void setEntity(float nx, float ny){
    
    int i = floor(nx * sizeX / width);
    int j = floor(ny * sizeY / height);
    
    entX = i;
    entY = j;
    
  }
  
  
  void calcDumpDist(){
    
    for(int i = 0; i < sizeX; i++){
      for(int j = 0; j < sizeY; j++){
        
        grid[i][j] = floor(dist(i, j, dumpX, dumpY));
        
      }
    }
    
  }
  
  void calcStorageDist(){
    
    for(int i = 0; i < sizeX; i++){
      for(int j = 0; j < sizeY; j++){
        
        grid[i][j] = floor(dist(i, j, storX, storY));
        
      }
    }
    
  }
  
  PVector getMovement(int state){
    
    PVector dist = new PVector();
    
    int lowX = 0, lowY = 0;
    int lowest = width;
    
    if(state == STATE_DUMPING){
      
      calcDumpDist();
      
    }else if(state == STATE_PICKING){
      
      calcStorageDist();
      
    }
    
    for(int i = 0; i < sizeX; i++){
      for(int j = 0; j < sizeY; j++){
        
        if(grid[i][j] < lowest){
          lowest = grid[i][j];
          lowX = i;
          lowY = j;
        }
        
      }
    }
    
    int newX = 0;
    int newY = 0;
    
    if(entX > lowX){
      newX = -1;
    }else if(entX < lowX){
      newX = 1;
    }
    
    if(entY > lowY){
      newY = -1;
    }else if(entY < lowY){
      newY = 1;
    }
    
    dist.x = float(newX) * width/GRID_RATIO;
    dist.y = float(newY) * height/GRID_RATIO;
    
    return dist;
    
    
  }
  
  void show(){
    
    for(int i = 0; i < sizeX; i++){
      for(int j = 0; j < sizeY; j++){
        
        if(i == entX && j == entY){
          fill(0, 0, 255);
        }else if(i == dumpX && j == dumpY){
          fill(255, 0, 0);
        }else if(i == storX && j == storY){
          fill(0, 255, 0);
        }else {
          noFill();
        }
        
        stroke(0);
        
        rect(i * (width/GRID_RATIO), j * (width/GRID_RATIO), (width/GRID_RATIO), (width/GRID_RATIO));
        
        
        fill(0);
        
        text(j, i * (width/GRID_RATIO), j * (width/GRID_RATIO));
        
        
      }
    }
    
  }
  
  
  
  
  
  
  
  
}
