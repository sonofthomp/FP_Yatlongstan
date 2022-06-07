class BoardScreen {
  BoardScreen() {
  }

  void keyPressed() {
    if (boardY < 9 && boardY >= 0 && boardX < 9 && boardX >= 0) {
      if (mode == 4 || canModify) {
        if (key >= 48 && key < 58 && (mode == 5 || gameBoard.isModifiable(boardY, boardX))) {
          int value = key - 48;
          gameBoard.setTile(boardY, boardX, value);
          if (mode == 4 && gameBoard.isSolved()) {
            mode = 6;
          }
        }
      }
    }

    if (keyCode == BACKSPACE) {
      gameBoard.setTile(boardY, boardX, 0);
    }

    if (keyCode == LEFT && boardX > 0) {
      boardX--;
    } else if (keyCode == RIGHT && boardX < 8) {
      boardX++;
    } else if (keyCode == UP && boardY > 0) {
      boardY--;
    } else if (keyCode == DOWN && boardY < 8) {
      boardY++;
    }

    if (gameBoard.isValidBoard()) {
      isBozo = false;
    } else {
      isBozo = true;
    }
  }

  void mousePressed() {
    if (mouseX >= leftMargin && mouseX <= 630 + leftMargin && mouseY >= topMargin && mouseY <= 630 + topMargin) {
      boardX = int(map(mouseX, leftMargin, 630 + leftMargin, 0, 9));
      boardY = int(map(mouseY, topMargin, 630 + topMargin, 0, 9));
    }


    if (mouseX >= 740 && mouseX <= 940 && mouseY >= 70 && mouseY <= 150) {
      if (mode == 5) {
        if (canModify && !isBozo) {
          for (int row = 0; row < 9; row++) {
            for (int col = 0; col < 9; col++) {
              if (gameBoard.getTile(row, col) == 0) {
                gameBoard.setModifiability(row, col, true);
              }
            }
          }
          gameBoard.solve();
          canModify = false;
        }
      } else {
        setup();
      }
    }

    if (mouseX >= 740 && mouseX <= 940 && mouseY >= 200 && mouseY <= 280) {
      if (mode == 5) {
        gameBoard = new NineBoard();
        canModify = true;
        boardX = boardY = 0;
      } else {
        exit();
      }
    }
    if (mouseX >= 740 && mouseX <= 940 && mouseY >= 330 && mouseY <= 410) {
      if (mode == 5) {
        setup();
      }
    }
  }

  void show() {
    int tileSize = 71;//(height) / 9 + 1;

    // highlight selected tile
    fill(175, 238, 238);
    stroke(142);
    strokeWeight(3);
    rect(tileSize * boardX + leftMargin, tileSize * boardY + topMargin, tileSize, tileSize);


    for (int row = 0; row < gameBoard.length(); row ++) {
      for (int col = 0; col < gameBoard.length(); col ++) {
        // TILES
        if (row != boardY || col != boardX) {
          fill(255);
          stroke(142);
          strokeWeight(3);
          rect(tileSize * col + leftMargin, tileSize * row + topMargin, tileSize, tileSize);
        }

        // TEXT
        textAlign(CENTER);

        // change text color based on whether or not tile is modifiable
        if (gameBoard.getTile(row, col) != 0) {
          if (gameBoard.isModifiable(row, col) ) {
            fill(0, 0, 255);
          } else {
            fill(0);
          }
          // center and display text on tile
          textSize(25);
          text( str(gameBoard.getTile(row, col)),
            (tileSize * col) + (tileSize / 2) + leftMargin, (tileSize * row) + (tileSize / 3 * 2) + topMargin );
        }
      }
    }

    // borders for each 3x3 section
    stroke(0);
    strokeWeight(5);
    for (int i = 3; i < gameBoard.length(); i += 3) {
      line(tileSize * i + leftMargin, 0 + topMargin, tileSize * i + leftMargin, 639 + topMargin);
      line(0 + leftMargin, tileSize * i + topMargin, 639 + leftMargin, tileSize * i + topMargin);
    }

    if (mode == 5) {
      fill(128, 128, 255);
      strokeWeight(2);
      rect(740, 70, 200, 80);
      fill(255);
      textSize(40);
      text("SOLVE", 840, 123);

      fill(128, 128, 255);
      strokeWeight(2);
      rect(740, 200, 200, 80);
      fill(255);
      textSize(35);
      text("CLEAR", 840, 253);

      fill(128, 128, 255);
      strokeWeight(2);
      rect(740, 330, 200, 80);
      fill(255);
      textSize(35);
      text("START MENU", 840, 383);

      if (isBozo) {
        fill(255, 0, 0);
        textSize(40);
        text("BOZO", mouseX, mouseY);
      }
    } else {
      fill(128, 128, 255);
      strokeWeight(2);
      rect(740, 70, 200, 80);
      fill(255);
      textSize(35);
      text("START MENU", 840, 123);

      fill(128, 128, 255);
      strokeWeight(2);
      rect(740, 200, 200, 80);
      fill(255);
      textSize(35);
      text("QUIT", 840, 253);
    }
  }
}
