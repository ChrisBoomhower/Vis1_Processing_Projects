void dance() {
  //tint(255, 255);
  //image(cactus, 420, 435, 35, 65);

  if (amptest >= 1) {
    transparent(0);
    image(dancer, 155, 350, 85, 150);
  }
  
  if (amptest >= 2) {
    transparent(1);
    image(cactus, 420, 435, 35, 65);
  }
  
  if (amptest >= 3) {
    transparent(2);
    image(panda, 100, 350, 50, 100);
  }
  
  if (amptest >= 4) {
    transparent(3);
    image(fox, 470, 440, 30, 50);
  }
  
  if (amptest >= 5) {
    transparent(4);
    image(Peng, 230, 350, 75, 125);
  }
  
  if (amptest >= 6) {
    transparent(5);
    image(jumper, 000, 350, 85, 150);
  }
}

void transparent(int i) {
  transparency[i] += 2;
    if (transparency[i] < 255) tint(255, transparency[i]);
    else tint(255, 255);
}