class BoardSizeMenu implements Menu {
  float length = width * .35;
  float b1X = width * .1;
  float b2X = width * .55;
  float bY = height / 2;

  BoardSizeMenu() {
  }

  void show() {
    background(128, 128, 255);
    fill(255);
    textSize(72);
    textAlign(CENTER);
    text("Choose a board size", width / 2, height * .3 + 40);

    rect(b1X, height / 2, length, length, 30);
    rect(b2X, height / 2, length, length, 30);
    fill(0);
    textAlign(CENTER);
    textSize(24);
    text("9x9", width * .1 + length / 2, height / 2 + (length) / 2);
    text("16x16 (TO BE IMPLEMENTED)", width * .55 + length / 2, height / 2 + (length) / 2);
  }

  void mousePressed() {
    if (mouseX > b1X && mouseX < (b1X + length) && mouseY > bY && mouseY < bY + length  ) {
      gameBoard = new NineBoard();
      if (player) {
        mode = 4;
        gameBoard.generate(50);
      } else {
        mode = 5;
      }
    }
    /*
    if (mouseX > b2X && mouseX < (b2X + length) && mouseY > bY && mouseY < bY + length / 2) {
     if (player == true) {
     mode = 4;
     }
     mode = 5;
     } */
  }
}
