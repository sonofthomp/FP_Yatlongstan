Board gameBoard;

// x and y mapped from mouse clicked to array indices
int boardX;
int boardY;
int mode;
Menu menu;

int leftMargin = 50;
int topMargin = 50;

void setup() {
  boardX = boardY = -1;
  size(1000, 750); // width and height should be ==
  mode = 1;
  gameBoard = new Board();
  menu = new StartMenu();
}



void draw() {
  background(255);
  switch (mode) {
  case 1:
    menu.show();
    break;
  case 2:
    menu = new DifficultyMenu();
    menu.show();
    break;
  case 3:
    menu = new BoardSizeMenu();
    menu.show();
    break;
  case 4:
    drawBoard();
    break;
  default:
    break;
  }
  //drawBoard();
}

void drawBoard() {
  int tileSize = 71;//(height) / 9 + 1;

  // highlight selected tile
  if (boardX > - 1) {
    if (gameBoard.isModifiable(boardY, boardX)) {
      fill(175, 238, 238);
    } else {
      fill(255);
    }
    stroke(142);
    strokeWeight(3);
    rect(tileSize * boardX + leftMargin, tileSize * boardY + topMargin, tileSize, tileSize);
  }


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
  strokeWeight(7);
  for (int i = 3; i < gameBoard.length(); i += 3) {
    line(tileSize * i + leftMargin, 0 + topMargin, tileSize * i + leftMargin, 639 + topMargin);
    line(0 + leftMargin, tileSize * i + topMargin, 639 + leftMargin, tileSize * i + topMargin);
  }
}

void mousePressed() {
  switch (mode) {
  case 1:
    menu.mousePressed();
    break;
  case 2:
    break;
  case 3:
    break;
  case 4:
    boardX = int(map(mouseX, leftMargin, 630 + leftMargin, 0, 9));
    boardY = int(map(mouseY, topMargin, 630 + topMargin, 0, 9));
    break;
  default:
    break;
  }
}

void keyPressed() {
  if (key > 48 && key < 58 && gameBoard.isModifiable(boardY, boardX)) {
    int value = key - 48;
    gameBoard.setTile(boardY, boardX, value);
  }
}
