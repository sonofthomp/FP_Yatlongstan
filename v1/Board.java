/*
BASIC SUDOKU RULES:

1. Each row must contain 1-9 w/ no repetitions
2. Each col must contain 1-9 w/ no repetitions
3. Each 3 by 3 subsection must contain 1-9 w/ no repetitions
*/

public class Board {
    private int _board[][];
    private boolean _isModifiable[][];
    // default constructor: 9 by 9 board
    public Board() {
        _board = new int[9][9];
        _isModifiable = new boolean[9][9];
    }

    // accessor: return value at (r,c)
    public int getTile(int r, int c) {
        return _board[r][c];
    }

    // mutator: set value at (r,c) to newVal
    public int setTile(int r, int c, int newVal) {
        int oldVal = _board[r][c];
        _board[r][c] = newVal;
        return oldVal;
    }

    public String toString() {
	String out = "";
        for (int[] row : _board) {
		for (int col : row) {
			out += col + " ";
		}
		out += "\n";
	}
	return out;
    }

	//recursive backtracking to solve sudoku puzzle
    public void solve() {
	solveHelper(0,0);
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
    public boolean solveHelper(int startRow, int startCol) {
	if (startRow > 8 || startCol > 8)
		return true;
       if (!_isModifiable[startRow][startCol]) {
		if (startCol == 8) {
			return solveHelper(startRow + 1, 0);
		} else {
			return solveHelper(startRow, startCol + 1);
		}
       }

 
       for (int i = 1; i <= 9; i ++) {
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
    public void generate(int numExcluded) {
        fillBoard(0, 0);
	int randomRow;
	int randomCol;
	for (int i = 0; i < numExcluded; i++) {
		randomRow = (int)(Math.random()*9);
		randomCol = (int)(Math.random()*9);
		while (_isModifiable[randomRow][randomCol]) {
			randomRow = (int)(Math.random()*9);
			randomCol = (int)(Math.random()*9);
		}
		if (_board[randomRow][randomCol] != 0) {
			_board[randomRow][randomCol] = 0;
			_isModifiable[randomRow][randomCol] = true;
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

    public boolean fillBoard(int startRow, int startCol) {
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

    public boolean isValidMove(int row, int col, int num) {
	//check row
	for (int searchCol = 0; searchCol < 9; searchCol++) {
		if (num == _board[row][searchCol]) {
			return false;
		}
	}
		//check col
        for (int searchRow = 0; searchRow < 9; searchRow++) {
                if (num == _board[searchRow][col]) {
                        return false;
                }
        }

	//check 3x3
	row -= row % 3;
	col -= col % 3;
	for (int searchRow = row; searchRow < row + 3; searchRow++)
		for (int searchCol = col; searchCol < col + 3; searchCol++)
			if (num == _board[searchRow][searchCol])
				return false;
	return true;
    }

	//Check if board is filled. Used for user gameplay
    public boolean isFilled() {
	for (int row = 0; row < 9; row++)
		for (int col = 0; col < 9; col++)
			if (_board[row][col] == 0)
				return false;
	return true;
    }

    // checks if puzzle is solved. Used for user gameplay
    public boolean isSolved() {
        boolean[] found;

	// check if rows are valid
	for (int row = 0; row < 9; row++) {
		found = new boolean[9];
		for (int col = 0; col < 9; col++) {
			if (found[_board[row][col] - 1]) {
				return false;
			}
			found[_board[row][col] - 1] = true;
		}
	}

		// check if columns are valid
        for (int col = 0; col < 9; col++) {
                found = new boolean[9];
                for (int row = 0; row < 9; row++) {
                        if (found[_board[row][col] - 1]) {
                                return false;
                        }
                        found[_board[row][col] - 1] = true;
                }
        }

	// check if each 3x3 section is valid
	for (int outerBoxRow = 0; outerBoxRow < 3; outerBoxRow++) {
		for (int outerBoxCol = 0; outerBoxCol < 3; outerBoxCol++) {
			found = new boolean[9];
			for (int innerBoxRow = 3 * outerBoxRow; innerBoxRow < (3 * outerBoxRow + 3); innerBoxRow++) {
				for (int innerBoxCol = 3 * outerBoxCol; innerBoxCol < (3 * outerBoxCol + 3); innerBoxCol++) {
					if (found[_board[innerBoxRow][innerBoxCol] - 1]) {
						return false;
					}
					found[_board[innerBoxRow][innerBoxCol] - 1] = true;
				}
			}
		}
	}

        return true;
    }
}
