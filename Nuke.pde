class Nuke{
  
  PVector pos;
  
  float size;
  
  boolean alive;
  
  Nuke(float x, float y){
    
    pos = new PVector(x, y);
    size = 0;
    
    alive = true;
    
  }
  
  boolean isAlive(){return alive;}
  
  boolean contact(PVector opos, float osize){
    if(dist(pos.x, pos.y, opos.x, opos.y) < size/2 + osize/2){
      return true;
    }
    return false;
  }
  
  void update(){
    
    if(size < height/2){
      size += 10;
    }else {
      alive = false;
    }
    
  }
  
  
  void show(){
    
    stroke(200, 150, 0);
    fill(250, 200, 0, 150);
    
    ellipse(pos.x, pos.y, size, size);
    
  }
  
  
}
