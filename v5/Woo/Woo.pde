Board gameBoard;

// x and y mapped from mouse clicked to array indices
int boardX;
int boardY;
int mode;
boolean player;
boolean isBozo;
boolean canModify;
Menu menu;

int leftMargin = 50;
int topMargin = 50;

void setup() {
  boardX = boardY = -1;
  size(1000, 750); // width and height should be ==
  mode = 1;
  player = false;
  gameBoard = new Board();
}



void draw() {
  background(255);
  strokeWeight(0);
  switch (mode) {
    case 1:
      menu = new StartMenu();
      break;
    case 2:
      menu = new DifficultyMenu();
      break;
    case 3:
      menu = new BoardSizeMenu();
      break;
    case 6:
      menu = new VictoryScreen();
      break;
    default:
      break;
  }
  if (mode == 4 || mode == 5) {
    drawBoard();
  } else {
    menu.show();
  }
}

void drawBoard() {
  int tileSize = 71;//(height) / 9 + 1;

  // highlight selected tile
  if (boardX > -1 && boardX < 9 && boardY < 9) {
    if (mode == 5 || gameBoard.isModifiable(boardY, boardX)) {
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
    
    if (isBozo) {
      fill(255, 0, 0);
      text("BOZO", 400, 370);
    }
  }
}

void mousePressed() {

  if (mode == 4 || mode == 5 && canModify) {
    boardX = int(map(mouseX, leftMargin, 630 + leftMargin, 0, 9));
    boardY = int(map(mouseY, topMargin, 630 + topMargin, 0, 9));
  } else {
    menu.mousePressed();
  }
  
  if (mode == 5 && canModify) {
    if (mouseX >= 740 && mouseX <= 940 && mouseY >= 70 && mouseY <= 150) {
      for (int row = 0; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
          if (gameBoard.getTile(row, col) == 0) {
            gameBoard.setModifiability(row, col, true);
          }
        }
      }
      if (!isBozo) {
        gameBoard.solve();
        canModify = false;
      }
    }
  }
}

void keyPressed() {

  if (key >= 48 && key < 58 && (mode == 5 || gameBoard.isModifiable(boardY, boardX))) {
    int value = key - 48;
    gameBoard.setTile(boardY, boardX, value);
    if (gameBoard.isSolved()) {
      if (mode != 5) {
        mode = 6;
      }
    }
  }
  
  if (gameBoard.isValidBoard()) {
    isBozo = false;
  } else {
    isBozo = true;
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
}
