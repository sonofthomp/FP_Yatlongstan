class VictoryScreen implements Menu {
  float length = width * .35;
  float b1X = width * .1;
  float b2X = width * .55;
  float bY = height / 2;

  VictoryScreen() {
  }

  void show() {
    background(128, 128, 255);
    fill(255);
    textSize(72);
    textAlign(CENTER);
    text("YOU WIN !!!", width / 2, height * .3 + 40);

    rect(b1X, height / 2, length, length, 30);
    rect(b2X, height / 2, length, length, 30);
    fill(0);
    textAlign(CENTER);
    textSize(24);
    text("QUIT", width * .1 + length / 2, height / 2 + (length) / 2);
    text("Back to Start", width * .55 + length / 2, height / 2 + (length) / 2);
  }

  void mousePressed() {
    if (mouseX > b1X && mouseX < (b1X + length) && mouseY > bY && mouseY < bY + length / 2) {
      exit();
    }

    if (mouseX > b2X && mouseX < (b2X + length) && mouseY > bY && mouseY < bY + length / 2) {
      mode = 1;
      gameBoard = new Board();
    }
  }
}
