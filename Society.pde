void setup(){
  
  size(1280, 720);
  
  textAlign(CENTER, CENTER);
  
  reset();
  
}


void reset(){
  
  ENTITY_AMOUNT = int(random(15, 50));
  //ENTITY_AMOUNT = 5000;
  
  dump = new Dump(new PVector(width/2 - 2, height/2 + 2), height/25);
  storage = new Storage(new PVector(width/8, height/2 + 2), height/25);
  
  entities = new ArrayList<Entity>();
  nukes = new ArrayList<Nuke>();
  
  
  for(int i = 0; i <  ENTITY_AMOUNT; i++){
    
    entities.add(new Entity());
    
  }
  
  entities.get(int(random(ENTITY_AMOUNT))).setMaster();
  
  lastDeath = millis();
  deathResetTime = 60000;
  
}



void draw(){
  
  background(150);
  
  storage.show();
  dump.show();
  
  int aliveCount = 0;
  
  for(int i = 0; i < entities.size(); i++){
    
    Entity part = entities.get(i);
    
    part.update();
    part.show(i);
    
    for(int j = nukes.size() - 1; j >= 0; j--){
      
      Nuke nuke = nukes.get(j);
      
      if(nuke.contact(part.getPos(), part.getSize()) && part.isAlive()){
        if(!part.isMaster()){
          part.kill();
        }
      }
      
    }
    
    if(part.isAlive()){
      aliveCount++;
    }else {
      if(part.justDied()){
        lastDeath = millis();
        part.confirmDeath();
      }
    }
    
  }
  
  
  for(int j = nukes.size() - 1; j >= 0; j--){
    
    Nuke nuke = nukes.get(j);
    
    nuke.update();
    nuke.show();

    if(!nuke.isAlive()){
      nukes.remove(j);
    }
  
  }
  
  fill(0);
  
  text("Initial Society Size: " + ENTITY_AMOUNT, textWidth("Initial Society Size: " + ENTITY_AMOUNT)/2, 8);
  text("Current Society Size: " + aliveCount, textWidth("Current Society Size: " + aliveCount)/2, 8+15);
  
  if(millis() - lastDeath >= deathResetTime){
    reset();
  }
  
  
}



void mousePressed(){
  
  nukes.add(new Nuke(mouseX, mouseY));
  
}


void keyPressed(){
  
  if(key == ' '){
    reset();
  }
  
}
