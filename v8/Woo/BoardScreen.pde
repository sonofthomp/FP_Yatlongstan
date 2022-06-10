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
    // if mouse is on board, map mouse coords to board index
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
          println(timeToSolve);

          canModify = false;
        }
      } else {
        // START MENU IN MODE 4
        setup();
      }
    }

    if (mouseX >= 740 && mouseX <= 940 && mouseY >= 590 && mouseY <= 670) {
      if (mode == 5) {
        if (gameBoard.length() == 9) {
          int[][] newboard = {
            {0, 0, 0, 2, 6, 0, 7, 0, 1},
            {6, 8, 0, 0, 7, 0, 0, 9, 0},
            {1, 9, 0, 0, 0, 4, 5, 0, 0},
            {8, 2, 0, 1, 0, 0, 0, 4, 0},
            {0, 0, 4, 6, 0, 2, 9, 0, 0},
            {0, 5, 0, 0, 0, 3, 0, 2, 8},
            {0, 0, 9, 3, 0, 0, 0, 7, 4},
            {0, 4, 0, 0, 5, 0, 0, 3, 6},
            {7, 0, 3, 0, 1, 8, 0, 0, 0}
          };

          for (int row = 0; row < 9; row++) {
            for (int col = 0; col < 9; col++) {
              gameBoard.setTile(row, col, newboard[row][col]);
            }
          }
        }
        if (gameBoard.length() == 16) {
          int[][] newboard = {
            {12, 2, 0, 7, 0, 0, 0, 16, 6, 15, 0, 0, 0, 3, 0, 14},
            {0, 0, 0, 9, 12, 0, 2, 0, 0, 0, 0, 0, 16, 1, 0, 6},
            {0, 11, 0, 13, 0, 0, 7, 0, 4, 0, 8, 0, 0, 0, 15, 0},
            {0, 8, 0, 3, 0, 0, 1, 0, 0, 0, 16, 13, 11, 0, 4, 2},
            {0, 0, 15, 0, 0, 0, 0, 0, 1, 6, 11, 0, 0, 0, 3, 0},
            {3, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 16, 8, 0, 6, 12},
            {0, 0, 0, 14, 2, 0, 0, 0, 0, 12, 0, 0, 7, 4, 0, 0},
            {0, 12, 8, 4, 10, 0, 0, 14, 7, 0, 9, 3, 15, 0, 0, 0},
            {0, 0, 0, 16, 3, 7, 0, 4, 5, 0, 0, 9, 10, 14, 13, 0},
            {0, 0, 13, 8, 0, 0, 11, 0, 0, 0, 0, 12, 4, 0, 0, 0},
            {4, 9, 0, 5, 15, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 11},
            {0, 14, 0, 0, 0, 6, 13, 1, 0, 0, 0, 0, 0, 7, 0, 0},
            {9, 1, 0, 15, 7, 4, 0, 0, 0, 16, 0, 0, 3, 0, 14, 0},
            {0, 3, 0, 0, 0, 9, 0, 2, 0, 1, 0, 0, 5, 0, 10, 0},
            {16, 0, 4, 12, 0, 0, 0, 0, 0, 3, 0, 14, 1, 0, 0, 0},
            {5, 0, 14, 0, 0, 0, 16, 15, 9, 0, 0, 0, 2, 0, 12, 4},
          };

          for (int row = 0; row < 16; row++) {
            for (int col = 0; col < 16; col++) {
              gameBoard.setTile(row, col, newboard[row][col]);
            }
          }
        }
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

    if (mouseX >= 740 && mouseX <= 940 && mouseY >= 460 && mouseY <= 540) {
      if (mode == 5) {
        // exit IN MODE 5
        exit();
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
      // button to solve board
      fill(128, 128, 255);
      strokeWeight(2);
      rect(740, 70, 200, 80);
      fill(255);
      textSize(40);
      text("SOLVE", 840, 123);

      // button to clear board
      fill(128, 128, 255);
      strokeWeight(2);
      rect(740, 200, 200, 80);
      fill(255);
      textSize(35);
      text("CLEAR", 840, 253);

      // button to go to start menu
      fill(128, 128, 255);
      strokeWeight(2);
      rect(740, 330, 200, 80);
      fill(255);
      textSize(35);
      text("START MENU", 840, 383);

      // button to quit
      fill(128, 128, 255);
      strokeWeight(2);
      rect(740, 460, 200, 80);
      fill(255);
      textSize(35);
      text("QUIT", 840, 513);

      // button to example
      fill(128, 128, 255);
      strokeWeight(2);
      rect(740, 590, 200, 80);
      fill(255);
      textSize(35);
      text("EXAMPLE", 840, 643);

      if (isBozo) {
        // display bozo if board is invalid
        fill(255, 0, 0);
        textSize(40);
        text("BOZO", mouseX, mouseY);
      }

      if (gameBoard.isSolved()) {
        // displayy time to solve
        fill(255, 128, 255);
        rect(740, 690, 200, 30);
        fill(255);
        textSize(16);
        strokeWeight(3);
        text("Solved in " + str((float)timeToSolve/1000) + " seconds", 840, 710);
      }
    } else {
      // start menu
      fill(128, 128, 255);
      strokeWeight(2);
      rect(740, 70, 200, 80);
      fill(255);
      textSize(35);
      text("START MENU", 840, 123);

      // quit
      fill(128, 128, 255);
      strokeWeight(2);
      rect(740, 200, 200, 80);
      fill(255);
      textSize(35);
      text("QUIT", 840, 253);
    }
  }
}
