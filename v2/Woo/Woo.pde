Board gameBoard;

// x and y mapped from mouse clicked to array indices
int boardX;
int boardY;

void setup() {
  boardX = boardY = -1;
  size(700, 700); // width and height should be ==
  gameBoard = new Board();
  gameBoard.generate(70);
}

void draw() {
  background(255);
  drawBoard();
}

void drawBoard() {
  int tileSize = (width) / 9 + 1;

  // highlight selected tile
  if (boardX > - 1) {
    if (gameBoard.isModifiable(boardY, boardX)) {
      fill(175, 238, 238);
    } else {
      fill(255);
    }
    stroke(142);
    strokeWeight(3);
    rect(tileSize * boardX, tileSize * boardY, tileSize, tileSize);
  }


  for (int row = 0; row < gameBoard.length(); row ++) {
    for (int col = 0; col < gameBoard.length(); col ++) {
      // TILES
      if (row != boardY || col != boardX) {
        fill(255);
        stroke(142);
        strokeWeight(3);
        rect(tileSize * col, tileSize * row, tileSize, tileSize);
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
          (tileSize * col) + (tileSize / 2), (tileSize * row) + (tileSize / 3 * 2) );
      }
    }
  }

  // borders for each 3x3 section
  stroke(0);
  strokeWeight(3);
  for (int i = 3; i < gameBoard.length(); i += 3) {
    line(tileSize * i, 0, tileSize * i, height);
    line(0, tileSize * i, width, tileSize * i);
  }
}

void mousePressed() {
  boardX = int(map(mouseX, 0, width, 0, 9));
  boardY = int(map(mouseY, 0, height, 0, 9));
}
