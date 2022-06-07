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

int leftMargin = 50;
int topMargin = 50;

void setup() {
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
  if (mode == 4 || mode == 5) {
    screen.show();
  } else {
    menu.show();
  }
}


void mousePressed() {
  if (mode == 4 || mode == 5) {
    screen.mousePressed();
  } else {
    menu.mousePressed();
  }
}





void keyPressed() {
  if (mode == 4 || mode == 5) {
    screen.keyPressed();
  }
}
