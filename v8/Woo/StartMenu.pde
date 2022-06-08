class StartMenu implements Menu {
  float length = width * .35;
  float b1X = width * .1;
  float b2X = width * .55;
  float bY = height / 2;

  StartMenu() {
  }

  void show() {
    background(128, 128, 255);
    fill(255);
    textSize(72);
    textAlign(CENTER);
    text("Sudoku!", width / 2, height * .3);
    textSize(24);
    text("By Yatlongstan", width / 2, height * .3 + 40);

    rect(b1X, height / 2, length, length, 30);
    rect(b2X, height / 2, length, length, 30);
    fill(0);
    textAlign(CENTER);
    text("Solve a generated puzzle", width * .1 + length / 2, height / 2 + (length) / 2);
    text("Create a puzzle", width * .55 + length / 2, height / 2 + (length) / 2);
  }

  void mousePressed() {
    if (mouseX > b1X && mouseX < (b1X + length) && mouseY > bY && mouseY < bY + length) {
      player = true;
      mode = 3;
    }

    if (mouseX > b2X && mouseX < (b2X + length) && mouseY > bY && mouseY < bY + length) {
      canModify = true;
      mode = 3;
    }
  }
}
