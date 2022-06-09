/*
BASIC SUDOKU RULES:
 
 1. Each row must contain 1-n w/ no repetitions
 2. Each col must contain 1-n w/ no repetitions
 3. Each n by n subsection must contain 1-n w/ no repetitions
 */

class GeneralBoard {
  int board[][];
  boolean isModifiable[][];
  int size;

  // constructor: create n by n board
   GeneralBoard(int newSize) {
    size = newSize;
    board = new int[size * size][size * size];
    isModifiable = new boolean[size * size][size * size];
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
    if (startRow > (board.length - 1) || startCol > (board.length - 1))
      return true;
    if (!isModifiable[startRow][startCol]) {
      if (startCol == (board.length - 1)) {
        return solveHelper(startRow + 1, 0);
      } else {
        return solveHelper(startRow, startCol + 1);
      }
    }

    for (int i = 1; i <= board.length; i ++) {
      if (isValidMove(startRow, startCol, i)) {
        setTile(startRow, startCol, i);
        boolean solved;
        if (startCol == (board.length - 1)) {
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
      randomRow = (int)(Math.random()*board.length);
      randomCol = (int)(Math.random()*board.length);
      while (isModifiable[randomRow][randomCol]) {
        randomRow = (int)(Math.random()*board.length);
        randomCol = (int)(Math.random()*board.length);
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
    if (startRow > (board.length - 1) || startCol > (board.length - 1))
      return true;

    int[] nums = new int[board.length];
    for (int i = 0; i < board.length; i++)
      nums[i] = i + 1;
    for (int i = 0; i < 30; i++) {
      int r1 = (int)(Math.random() * board.length);
      int r2 = (int)(Math.random() * board.length);
      int temp = nums[r1];
      nums[r1] = nums[r2];
      nums[r2] = temp;
    }

    for (int i : nums) {
      if (isValidMove(startRow, startCol, i)) {
        setTile(startRow, startCol, i);
        boolean solved;
        if (startCol == (board.length - 1)) {
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

  boolean isValidBoard() {
    // check rows
    int[] seen;
    for (int row = 0; row < board.length; row++) {
      seen = new int[board.length];
      for (int col = 0; col < board.length; col++) {
        if (board[row][col] == 0) {
          continue;
        }
        if (seen[board[row][col] - 1] != 0) {
          return false;
        }
        seen[board[row][col] - 1]++;
      }
    }

    // check cols
    for (int col = 0; col < board.length; col++) {
      seen = new int[board.length];
      for (int row = 0; row < board.length; row++) {
        if (board[row][col] == 0) {
          continue;
        }
        if (seen[board[row][col] - 1] != 0) {
          return false;
        }
        seen[board[row][col] - 1]++;
      }
    }

    // check squares
    for (int boxRow = 0; boxRow < size; boxRow++) {
      for (int boxCol = 0; boxCol < size; boxCol++) {
        seen = new int[board.length];
        for (int row = 0; row < size; row++) {
          for (int col = 0; col < size; col++) {
            if (board[size * boxRow + row][size * boxCol + col] == 0) {
              continue;
            }
            if (seen[board[size * boxRow + row][size * boxCol + col] - 1] != 0) {
              return false;
            }
            seen[board[size * boxRow + row][size * boxCol + col] - 1]++;
          }
        }
      }
    }

    return true;
  }

  boolean isValidMove(int row, int col, int num) {
    //check row
    for (int searchCol = 0; searchCol < board.length; searchCol++) {
      if (num == board[row][searchCol]) {
        return false;
      }
    }
    //check col
    for (int searchRow = 0; searchRow < board.length; searchRow++) {
      if (num == board[searchRow][col]) {
        return false;
      }
    }

    //check nxn
    row -= row % size;
    col -= col % size;
    for (int searchRow = row; searchRow < row + size; searchRow++)
      for (int searchCol = col; searchCol < col + size; searchCol++)
        if (num == board[searchRow][searchCol])
          return false;
    return true;
  }

  //Check if board is filled. Used for user gameplay
  boolean isFilled() {
    for (int row = 0; row < board.length; row++)
      for (int col = 0; col < board.length; col++)
        if (board[row][col] == 0)
          return false;
    return true;
  }

  // checks if puzzle is solved. Used for user gameplay
  boolean isSolved() {
    boolean[] found;

    // check if rows are valid
    for (int row = 0; row < board.length; row++) {
      found = new boolean[board.length];
      for (int col = 0; col < board.length; col++) {
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
    for (int col = 0; col < board.length; col++) {
      found = new boolean[board.length];
      for (int row = 0; row < board.length; row++) {
        if (found[board[row][col] - 1]) {
          return false;
        }
        found[board[row][col] - 1] = true;
      }
    }

    // check if each 3x3 section is valid
    for (int outerBoxRow = 0; outerBoxRow < size; outerBoxRow++) {
      for (int outerBoxCol = 0; outerBoxCol < size; outerBoxCol++) {
        found = new boolean[board.length];
        for (int innerBoxRow = size * outerBoxRow; innerBoxRow < (size * outerBoxRow + size); innerBoxRow++) {
          for (int innerBoxCol = size * outerBoxCol; innerBoxCol < (size * outerBoxCol + size); innerBoxCol++) {
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

  void setModifiability(int row, int col, boolean val) {
    isModifiable[row][col] = val;
  }

  int getSize() {
    return size;
  }
}
