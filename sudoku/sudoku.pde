void setup() {
  size(600, 600);
}

void draw() {
   
}

for (int smallBoardRow = 0; smallBoardRow < 3; smallBoardRow++) {
  for (int smallBoardCol = 0; smallBoardCol < 3; smallBoardCol++) {
    for (int row = 3 * smallBoardRow; row < 3 * smallBoardRow + 3; row++) {
      for (int col = 3 * smallBoardCol; col < 3 * smallBoardCol + 3; col++) {
        found[board[row][col]] = true;
      }
    }
  }
}
