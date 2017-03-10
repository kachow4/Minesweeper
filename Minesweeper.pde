import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20

public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20; 
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup (){
  size(400, 400);
  textAlign(CENTER, CENTER);
  Interactive.make( this );
  buttons = new MSButton [NUM_ROWS][NUM_COLS];
  for(int a = 0; a < buttons.length; a++){
    for(int b = 0; b < buttons[a].length; b++){
      buttons[a][b] = new MSButton(a, b);
    }
  }
  while(bombs.size() < 30){
    setBombs();
  }
}

public void setBombs(){
  int row = (int)(Math.random()*NUM_ROWS);
  int col = (int)(Math.random()*NUM_COLS);
  if (!bombs.contains(buttons[row][col])){
    bombs.add(buttons[row][col]);
  }
}

public void draw(){
  background( 0 );
  if (isWon())
    displayWinningMessage();
}

public boolean isWon(){  
  for(int a = 0; a < buttons.length; a++){
    for(int b = 0; b < buttons[a].length; b++){
      if(!bombs.contains(buttons[a][b]) && buttons[a][b].isMarked() || bombs.contains(buttons[a][b]) && buttons[a][b].isMarked() == false){
        return false;
      }
    }
  }
  return true;
}

public void displayLosingMessage(){
  buttons[9][2].setLabel("O");
  buttons[9][3].setLabel("o");
  buttons[9][4].setLabel("p");
  buttons[9][5].setLabel("s");
  buttons[9][6].setLabel("!");
  buttons[9][8].setLabel("T");
  buttons[9][9].setLabel("r");
  buttons[9][10].setLabel("y");
  buttons[9][12].setLabel("A");
  buttons[9][13].setLabel("g");
  buttons[9][14].setLabel("a");
  buttons[9][15].setLabel("i");
  buttons[9][16].setLabel("n");
  buttons[9][17].setLabel("!");      
}

public void displayWinningMessage(){
  buttons[9][1].setLabel("C");
  buttons[9][2].setLabel("o");
  buttons[9][3].setLabel("n");
  buttons[9][4].setLabel("g");
  buttons[9][5].setLabel("r");
  buttons[9][6].setLabel("a");
  buttons[9][7].setLabel("t");
  buttons[9][8].setLabel("s");
  buttons[9][9].setLabel("!");
  buttons[9][11].setLabel("Y");
  buttons[9][12].setLabel("o");
  buttons[9][13].setLabel("u");
  buttons[9][15].setLabel("W");
  buttons[9][16].setLabel("i");
  buttons[9][17].setLabel("n");
  buttons[9][18].setLabel("!");
}

public class MSButton{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc ){
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this );
  }

  public boolean isMarked(){
    return marked;
  }

  public boolean isClicked(){
    return clicked;
  }

  public void mousePressed (){
    clicked = true;
    if (keyPressed == true) {
        marked = !marked;
        if(marked == false){
           clicked = false;
        }
    } 
    else if (bombs.contains(this)) {
      displayLosingMessage();
    } 
    else if (countBombs(r, c) > 0) {
      label = "" + countBombs(r, c);
    } 
    else {
      if (isValid(r-1, c) && buttons[r-1][c].clicked == false)
        buttons[r-1][c].mousePressed();
      if (isValid(r+1, c) && buttons[r+1][c].clicked == false)
        buttons[r+1][c].mousePressed();
      if (isValid(r, c-1) && buttons[r][c-1].clicked == false)
        buttons[r][c-1].mousePressed();
      if (isValid(r, c+1) && buttons[r][c+1].clicked == false)
        buttons[r][c+1].mousePressed();
      if (isValid(r-1, c+1) && buttons[r-1][c+1].clicked == false)
        buttons[r-1][c+1].mousePressed();
      if (isValid(r+1, c-1) && buttons[r+1][c-1].clicked == false)
        buttons[r+1][c-1].mousePressed();
      if (isValid(r-1, c-1) && buttons[r-1][c-1].clicked == false)
        buttons[r-1][c-1].mousePressed();
      if (isValid(r+1, c+1) && buttons[r+1][c+1].clicked == false)
        buttons[r+1][c+1].mousePressed();
    }
  }


  public void draw () {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this)) 
      fill(255, 0, 230);
    else if (clicked)
      fill(106, 0, 199);
    else 
    fill(139, 231, 131);

    rect(x, y, width, height);
    fill(255);
    text(label, x+width/2, y+height/2);
  }

  public void setLabel(String newLabel){
    label = newLabel;
  }

  public boolean isValid(int row, int col){
    if (row >= 0 && col >= 0 && row < NUM_ROWS && col < NUM_COLS) {
      return true;
    }
    return false;
  }

  public int countBombs(int row, int col){
    int numBombs = 0;

    if (isValid(row - 1, col) && bombs.contains(buttons[row - 1][col])) {
      numBombs++;
    }
    if (isValid(row - 1, col - 1) && bombs.contains(buttons[row - 1][col - 1])) {
      numBombs++;
    }
    if (isValid(row, col - 1) && bombs.contains(buttons[row][col - 1])) {
      numBombs++;
    }
    if (isValid(row + 1, col - 1) && bombs.contains(buttons[row + 1][col - 1])) {
      numBombs++;
    }
    if (isValid(row + 1, col) && bombs.contains(buttons[row + 1][col])) {
      numBombs++;
    }
    if (isValid(row + 1, col + 1) && bombs.contains(buttons[row + 1][col + 1])) {
      numBombs++;
    }
    if (isValid(row, col + 1) && bombs.contains(buttons[row][col + 1])) {
      numBombs++;
    }
    if (isValid(row - 1, col + 1) && bombs.contains(buttons[row - 1][col + 1])) {
      numBombs++;
    }
    return numBombs;
  }
}



