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
        //generate(randNum);
    }

    // overload constructor: n by n board
    public Board(int n) {
        _board = new int[n][n];
        _isModifiable = new boolean[n][n];
        //generate(randNum);
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

    // fills board, then remove numExcluded tiles randomly
    /*
    1. Fill diagonmal square sections first
    2. fill remaining tiles by finding a safe number
    3. remove numExcluded tiles.
    */
    public void generate(int numExcluded) {
        /* TO BE IMPLEMENTED */
    }

    // checks if puzzle is solved
    public boolean isSolved() {
        /* TO BE IMPLEMENTED */
        return false;
    }
}