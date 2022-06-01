class StartMenu implements Menu{

    
  StartMenu(){}
  
  void show() {
    background(128, 128, 255);
    textSize(72);
    textAlign(CENTER);
    text("Sudoku!", width / 2, height * .3);
    textSize(24);
    text("By Yatlongstan", width / 2, height * .3 + 40);

    rect(width * .1, height / 2, width * .35, width * .35, 30);
    rect(width * .55, height / 2, width * .35, width * .35, 30);
    
    
  }
  
  
}
