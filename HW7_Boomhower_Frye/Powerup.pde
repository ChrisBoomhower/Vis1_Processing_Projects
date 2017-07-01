class Powerup {

  int count = 1;

  Powerup() {
  }

  void AddCount() {
    this.count = this.count+1;
  }

  int getCount() {
    return this.count;
  }
  
  boolean powerupFlag(){
    boolean bool;
    if (this.count % 5 == 0) bool = true;
    else bool = false;
    
    return bool;
  }

}