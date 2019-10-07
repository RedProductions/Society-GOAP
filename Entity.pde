class Entity {

  PVector pos;
  float size;


  boolean master;
  int carry;
  int maxCarry;

  int state;

  float lastMoved;
  float moveRate;

  int energy;
  int energyConsumed;

  boolean alive;
  boolean justDied;

  Grid grid;

  String status;
  
  
  float deathTime;
  float fadeTime;


  Entity() {

    pos = new PVector(width/2, height/2 + random(-height/4, height/4));
    size = height/50;

    lastMoved = 0;
    moveRate = random(50, 100);

    state = STATE_PICKING;
    carry = 0;
    maxCarry = int(random(2, 6));

    master = false;


    grid = new Grid();
    grid.setDump(dump.getPos().x, dump.getPos().y);
    grid.setStorage(storage.getPos().x, storage.getPos().y);

    energy = int(random(150, 300));
    energyConsumed = int(random(15, 35));

    alive = true;

    status = "Looking for food";
    
    deathTime = 0;
    fadeTime = 1000;
    
  }

  boolean isAlive() {return alive;}
  boolean justDied(){return justDied;}
  void confirmDeath(){justDied = false;}
  
  
  PVector getPos(){return pos;}
  float getSize(){return size;}
  
  
  boolean isMaster(){return master;}
  
  void kill(){
    alive = false;
    deathTime = millis();
    justDied = true;
  }


  void setMaster() {
    master = true;
    maxCarry = int(random(5, 15));
  }


  void update() {

    if (millis() - lastMoved >= moveRate && alive) {

      if (state == STATE_PICKING) {

        grid.setEntity(pos.x, pos.y);

        if (master) {
          grid.setStorage(storage.getPos().x, storage.getPos().y);
        }

        pos.add(grid.getMovement(state));

        if (grid.onStorage()) {

          grid.setStorage(storage.getPos().x, storage.getPos().y);

          if (grid.onStorage()) {
            if (carry < maxCarry) {
              carry += storage.grabCarry(maxCarry);
              energy += energyConsumed;
            } else {
              state = STATE_DUMPING;
              status = "Brigning back food";
            }
          } else {
            state = STATE_DUMPING;
            status = "Failed to find food";
          }
        }

        energy -= 1;
      } else if (state == STATE_DUMPING) {

        grid.setEntity(pos.x, pos.y);

        pos.add(grid.getMovement(state));

        if (grid.onDump()) {

          grid.setDump(dump.getPos().x, dump.getPos().y);

          if (grid.onDump()) {
            if (carry > 0) {
              carry--;
              dump.dumpCarry(1);
            } else {
              state = STATE_PICKING;

              boolean ok = true;

              while (energy < 250 && ok) {

                if (!dump.empty()) {
                  energy += dump.eat(3) * energyConsumed;
                } else {
                  ok = false;
                }
              }

              status = "Looking for food";
            }
          }
        }


        energy -= 1;
      }


      lastMoved = millis();

      if (energy <= 0) {
        alive = false;
        deathTime = millis();
        justDied = true;
      }
    } else if (!alive) {
      status = "Dead";
    }
  }


  void show(int i) {

    if (master) {
      stroke(225, 200, 0);
    } else {
      stroke(0);
    }


    if(alive){
      colorMode(HSB);
  
      fill(i * 255 / ENTITY_AMOUNT, 255, 255);
  
      colorMode(RGB);
      
    }else {
      stroke(0, 255 - (millis() - deathTime) * 255 / fadeTime);
      fill(0, 255 - (millis() - deathTime) * 255 / fadeTime);
    }


    if (alive) {
      ellipse(pos.x, pos.y, size, size);
    } else {
      rect(pos.x - size/2, pos.y - size/2, size, size);
    }
    
    colorMode(HSB);

    fill(i * 255 / ENTITY_AMOUNT, 255, 255);

    colorMode(RGB);

    if (master) {
      stroke(225, 200, 0);
    } else {
      stroke(0);
    }

    if (alive) {
      ellipse(size, 15 + (i+2) * (size+1), size, size);
    } else {
      rect(size/2, 15 + (i+2) * (size+1) - size/2, size, size);
    }

    fill(0);
    text(carry, size, 15 + (i+2) * (size+1));

    text("E:" + nf(energy, 3) + "  " + status, size*2 + textWidth("E:" + nf(energy, 3) + "  " + status)/2, 15 + (i+2) * (size+1));
  }
}
