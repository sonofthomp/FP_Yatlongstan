/*
BASIC SUDOKU RULES:
 
 1. Each row must contain 1-9 w/ no repetitions
 2. Each col must contain 1-9 w/ no repetitions
 3. Each 3 by 3 subsection must contain 1-9 w/ no repetitions
 */

class NineBoard extends GeneralBoard {

  public NineBoard() {
    super(3);
  }
}
