/*
mode 1 == start menu
 mode 2 == set difficulty
 mode 3 ==  set board size
 mode 4 == user solves board
 mode 5 == user creates a board
 mode 6 == victory screen
 */

GeneralBoard gameBoard;

// x and y mapped from mouse clicked to array indices
int boardX;
int boardY;
int mode;
boolean player;
boolean isBozo; // used to denote invalid moves
boolean canModify;
Menu menu;
BoardScreen screen;

int timeToSolve = 0;
int leftMargin = 50;
int topMargin = 50;

void setup() {
  surface.setTitle("SUDOKU");
  boardX = boardY = 0;
  size(1000, 750); // width and height should be ==
  mode = 1;
  player = false;
  screen = new BoardScreen();
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
  // 4 == play a puzzle, 5 == create a puzzle
  if (mode == 4 || mode == 5) {
    screen.show();
  } else {
    menu.show();
  }
}


void mousePressed() {
  if (mouseButton == LEFT) {
    if (mode == 4 || mode == 5) {
      screen.mousePressed();
    } else {
      menu.mousePressed();
    }
  }
}





void keyPressed() {
  if (mode == 4 || mode == 5) {
    screen.keyPressed();
  }
}
