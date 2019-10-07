class Dump{
  
  PVector pos;
  float size;
  
  int carry;
  
  Dump(PVector npos, float nsize){
    
    pos = new PVector(npos.x, npos.y);
    size = nsize;
    
    carry = 0;
    
  }
  
  
  PVector getPos(){return pos;}
  float getSize(){return size;}
  
  
  void dumpCarry(int dump){
    carry += dump;
  }
  
  int eat(int amount){
    
    int eaten = amount;
    
    if(amount > carry){
      eaten = carry;
      carry = 0;
    }else {
      carry -= amount;
    }
    
    return eaten;
  }
  
  
  boolean empty(){return carry <= 0;}
  
  
  void show(){
    
    stroke(0);
    fill(255, 0, 0);
    
    ellipse(pos.x, pos.y, size, size);
    
    
    fill(0);
    text(carry, pos.x, pos.y);
    
  }
  
  
  
}
