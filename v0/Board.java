public class Board {
    private int _board[][];
    private boolean _isModifiable[][];

    // default constructor: 9*9 board
    public Board() {
        _board = new int[9][9];
        _isModifiable = new boolean[9][9];
        //generate(randNum);
    }

    // overload constructor: n*n board
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

    public void generate(int numIncluded) {
        /* TO BE IMPLEMENTED */
    }

    public boolean isSolved() {
        /* TO BE IMPLEMENTED */
        return false;
    }
}