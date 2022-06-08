class BoardScreen {
  BoardScreen() {
  }

  void keyPressed() {

    // if in board
    if (boardY < gameBoard.length() && boardY >= 0 && boardX < gameBoard.length() && boardX >= 0) {
      // if mode == 4 or board isn't solved by cpu
      if (mode == 4 || canModify) {
        //check if key is 0-9, a-f, and if ur making a board or tile is modifiable
        if (((key >= 48 && key < 58) || ( (key >= 97 && key <= 102) && gameBoard.length() == 16)) && (mode == 5 || gameBoard.isModifiable(boardY, boardX))) {
          int value;
          if (key < 97) {
            value = key - 48;
            if (value == 0 && gameBoard.length() == 16) {
              value = 10; // 0 is mapped to 10 on the board array
            }
          } else {
              value = key - 86; // 11-16
          }
          gameBoard.setTile(boardY, boardX, value);
          if (mode == 4 && gameBoard.isSolved()) {
            mode = 6;
          }
        }
      }
    }

    // remove number from tile
    if ( keyCode == BACKSPACE) {
      if (mode == 5 || gameBoard.isModifiable(boardY, boardX)) {
        gameBoard.setTile(boardY, boardX, 0);
      }
    }

    // arrow keys
    if (keyCode == LEFT && boardX > 0) {
      boardX--;
    } else if (keyCode == RIGHT && boardX < gameBoard.length() - 1) {
      boardX++;
    } else if (keyCode == UP && boardY > 0) {
      boardY--;
    } else if (keyCode == DOWN && boardY < gameBoard.length() - 1) {
      boardY++;
    }

    // set bozo if in mode 5
    if (mode == 4 || gameBoard.isValidBoard()) {
      isBozo = false;
    } else {
      isBozo = true;
    }
  }

  void mousePressed() {
    if (mouseX >= leftMargin && mouseX <= 630 + leftMargin && mouseY >= topMargin && mouseY <= 630 + topMargin) {
      boardX = int(map(mouseX, leftMargin, 630 + leftMargin, 0, gameBoard.length()));
      boardY = int(map(mouseY, topMargin, 630 + topMargin, 0, gameBoard.length()));
    }


    // SOLVE BUTTON IN MODE 5
    if (mouseX >= 740 && mouseX <= 940 && mouseY >= 70 && mouseY <= 150) {
      if (mode == 5) {
        if (canModify && !isBozo) {
          for (int row = 0; row < gameBoard.length(); row++) {
            for (int col = 0; col < gameBoard.length(); col++) {
              if (gameBoard.getTile(row, col) == 0) {
                gameBoard.setModifiability(row, col, true);
              }
            }
          }
          int startTime = millis();
          gameBoard.solve();
          int endTime = millis();
          timeToSolve = endTime - startTime;

          canModify = false;
        }
      } else {
        // START MENU IN MODE 4
        setup();
      }
    }

    // CLEAR BOARD IN MODE 5
    if (mouseX >= 740 && mouseX <= 940 && mouseY >= 200 && mouseY <= 280) {
      if (mode == 5) {
        if (gameBoard.length() == 9)
          gameBoard = new NineBoard();
        else
          gameBoard = new HexBoard();
        canModify = true;
        boardX = boardY = 0;
      } else {
        // QUIT IN MODE 4
        exit();
      }
    }
    if (mouseX >= 740 && mouseX <= 940 && mouseY >= 330 && mouseY <= 410) {
      if (mode == 5) {
        // START MENU IN MODE 5
        setup();
      }
    }
  }

  void show() {
    int tileSize = 630 / gameBoard.length() + 1;

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
          String text = "";
          switch (gameBoard.getTile(row, col)) {
          case 11:
            text = "a";
            break;
          case 12:
            text = "b";
            break;
          case 13:
            text = "c";
            break;
          case 14:
            text = "d";
            break;
          case 15:
            text = "e";
            break;
          case 16:
            text = "f";
            break;
          }
          if (gameBoard.getTile(row, col) <= 10) {
            text = str(gameBoard.getTile(row, col) % 10);
          }
          text( text, (tileSize * col) + (tileSize / 2) + leftMargin, (tileSize * row) + (tileSize / 3 * 2) + topMargin );
        }
      }
    }

    // borders for each 3x3 section
    stroke(0);
    strokeWeight(5);
    for (int i = gameBoard.getSize(); i < gameBoard.length(); i += gameBoard.getSize()) {
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

      if (gameBoard.isSolved()) {
        fill(255, 128, 255);
        strokeWeight(2);
        rect(740, 460, 200, 80);
        fill(255);
        textSize(35);
        text(str((float)timeToSolve/1000) + " seconds", 840, 513);
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
