/*
BASIC SUDOKU RULES:
 
 1. Each row must contain 1-9 w/ no repetitions
 2. Each col must contain 1-9 w/ no repetitions
 3. Each 3 by 3 subsection must contain 1-9 w/ no repetitions
 */

class Board {
  int board[][];
  boolean isModifiable[][];

  // default constructor: 9 by 9 board
  Board() {
    board = new int[9][9];
    isModifiable = new boolean[9][9];
  }

  // length of board
  int length() {
    return board.length;
  }
  // accessor: return value at (r,c)
  int getTile(int r, int c) {
    return board[r][c];
  }
  
  // return if tile is modifiable
  boolean isModifiable(int r, int c) {
    return isModifiable[r][c];
  }

  // mutator: set value at (r,c) to newVal
  int setTile(int r, int c, int newVal) {
    int oldVal = board[r][c];
    board[r][c] = newVal;
    return oldVal;
  }

  String toString() {
    String out = "";
    for (int[] row : board) {
      for (int col : row) {
        out += col + " ";
      }
      out += "\n";
    }
    return out;
  }

  //recursive backtracking to solve sudoku puzzle
  void solve() {
    solveHelper(0, 0);
  }

  /*
        ALGO:
   To solve from one tile:
   if we're off the board
   return
   make a list of possible moves
   if tile is not modifiable
   recursively call next tile
   if there are any possible moves we can make
   for move in moves,
   make move
   recursively call next tile
   */
 boolean solveHelper(int startRow, int startCol) {
  if (startRow > 8 || startCol > 8)
    return true;
       if (!isModifiable[startRow][startCol]) {
    if (startCol == 8) {
      return solveHelper(startRow + 1, 0);
    } else {
      return solveHelper(startRow, startCol + 1);
    }
       }
     int[] nums = new int[9];
     for (int i = 0; i < 9; i++)
         nums[i] = i + 1;
     for (int i = 0; i < 30; i++) {
       int r1 = (int)(Math.random() * 9);
       int r2 = (int)(Math.random() * 9);
       int temp = nums[r1];
       nums[r1] = nums[r2];
       nums[r2] = temp;
  }

 
       for (int i : nums) {
    if (isValidMove(startRow, startCol, i)) {
      setTile(startRow, startCol, i);
         boolean solved;
      if (startCol == 8) {
        solved = solveHelper(startRow + 1, 0);
           } else {
        solved = solveHelper(startRow, startCol + 1);
           }
       if (solved) return true;

    }
       }
  setTile(startRow, startCol, 0);
  return false;

    }

  // fill sudoku board, then remove numExcluded tiles
  void generate(int numExcluded) {
    fillBoard(0, 0);
    int randomRow;
    int randomCol;
    for (int i = 0; i < numExcluded; i++) {
      randomRow = (int)(Math.random()*9);
      randomCol = (int)(Math.random()*9);
      while (isModifiable[randomRow][randomCol]) {
        randomRow = (int)(Math.random()*9);
        randomCol = (int)(Math.random()*9);
      }
      if (board[randomRow][randomCol] != 0) {
        board[randomRow][randomCol] = 0;
        isModifiable[randomRow][randomCol] = true;
      }
    }
  }

  /*
  ALGO:
   To solve from one tile:
   if we're off the board
   return
   make a list of possible moves
   if there are any possible moves we can make
   for move in moves,
   make move
   recursively call next tile
   */

  boolean fillBoard(int startRow, int startCol) {
    if (startRow > 8 || startCol > 8)
      return true;

    int[] nums = new int[9];
    for (int i = 0; i < 9; i++)
      nums[i] = i + 1;
    for (int i = 0; i < 30; i++) {
      int r1 = (int)(Math.random() * 9);
      int r2 = (int)(Math.random() * 9);
      int temp = nums[r1];
      nums[r1] = nums[r2];
      nums[r2] = temp;
    }

    for (int i : nums) {
      if (isValidMove(startRow, startCol, i)) {
        setTile(startRow, startCol, i);
        boolean solved;
        if (startCol == 8) {
          solved = fillBoard(startRow + 1, 0);
        } else {
          solved = fillBoard(startRow, startCol + 1);
        }
        if (solved) return true;
      }
    }
    setTile(startRow, startCol, 0);
    return false;
  }

  boolean isValidMove(int row, int col, int num) {
    //check row
    for (int searchCol = 0; searchCol < 9; searchCol++) {
      if (num == board[row][searchCol]) {
        return false;
      }
    }
    //check col
    for (int searchRow = 0; searchRow < 9; searchRow++) {
      if (num == board[searchRow][col]) {
        return false;
      }
    }

    //check 3x3
    row -= row % 3;
    col -= col % 3;
    for (int searchRow = row; searchRow < row + 3; searchRow++)
      for (int searchCol = col; searchCol < col + 3; searchCol++)
        if (num == board[searchRow][searchCol])
          return false;
    return true;
  }

  //Check if board is filled. Used for user gameplay
  boolean isFilled() {
    for (int row = 0; row < 9; row++)
      for (int col = 0; col < 9; col++)
        if (board[row][col] == 0)
          return false;
    return true;
  }

  // checks if puzzle is solved. Used for user gameplay
  boolean isSolved() {
    boolean[] found;

    // check if rows are valid
    for (int row = 0; row < 9; row++) {
      found = new boolean[9];
      for (int col = 0; col < 9; col++) {
        if (board[row][col] == 0) {
          return false;
        }
        if (found[board[row][col] - 1]) {
          return false;
        }
        found[board[row][col] - 1] = true;
      }
    }

    // check if columns are valid
    for (int col = 0; col < 9; col++) {
      found = new boolean[9];
      for (int row = 0; row < 9; row++) {
        if (found[board[row][col] - 1]) {
          return false;
        }
        found[board[row][col] - 1] = true;
      }
    }

    // check if each 3x3 section is valid
    for (int outerBoxRow = 0; outerBoxRow < 3; outerBoxRow++) {
      for (int outerBoxCol = 0; outerBoxCol < 3; outerBoxCol++) {
        found = new boolean[9];
        for (int innerBoxRow = 3 * outerBoxRow; innerBoxRow < (3 * outerBoxRow + 3); innerBoxRow++) {
          for (int innerBoxCol = 3 * outerBoxCol; innerBoxCol < (3 * outerBoxCol + 3); innerBoxCol++) {
            if (found[board[innerBoxRow][innerBoxCol] - 1]) {
              return false;
            }
            found[board[innerBoxRow][innerBoxCol] - 1] = true;
          }
        }
      }
    }

    return true;
  }
}
