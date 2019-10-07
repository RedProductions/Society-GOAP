class Storage{
  
  PVector pos;
  float size;
  
  int currentCarry;
  
  
  Storage(PVector npos, float nsize){
    
    pos = new PVector(npos.x, npos.y);
    size = nsize;
    
    currentCarry = int(random(35, 100));
    
  }
  
  PVector getPos(){return pos;}
  float getSize(){return size;}
  
  int grabCarry(int max){
    
    
    int current = currentCarry;
    if(current > max){
      current = max;
    }
    
    currentCarry -= current;
    
    
    
    if(currentCarry < 0){
      current = max + currentCarry;
      
      pos.x = random(width/16, width);
      pos.y = random(height);
      
      currentCarry = int(random(35, 100));
      
    }else if(currentCarry == 0){
      
      pos.x = random(width/16, width);
      pos.y = random(height);
      
      currentCarry = int(random(35, 100));
      
    }
    
    return current;
    
  }
  
  int getCarry(){return currentCarry;}
  
  void show(){
    
    stroke(0);
    fill(0, 255, 0);
    
    ellipse(pos.x, pos.y, size, size);
    
    
    fill(0);
    text(currentCarry, pos.x, pos.y);
    
  }
  
  
}
