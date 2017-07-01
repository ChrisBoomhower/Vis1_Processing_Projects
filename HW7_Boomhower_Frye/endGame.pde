

class gameOver {
  
  gameOver() {
  }
  
  void splashScreen() {
    fill(0);
    noStroke();
    rect(-1, -1, width+1, height+1);
    
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    if ((frameCount - fc)/3 < 120){
      if ((frameCount - fc)/3 < 1) textFont(fontGaming, 1);
      else textFont(fontGaming, (frameCount - fc)/3);
    }
    else{
      textFont(fontGaming, 120);
    }
    
    if(frameCount - fc > 3600) file.stop();
      
    text("Game Over!", width/2, height/2);
  }
}