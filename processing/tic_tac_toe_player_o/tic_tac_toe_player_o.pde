
  /////////////////////////////////////////////////////////////////
  //                                                             //
  //     T I C    T A C   T O E    P L A Y E R    O              //
  //                                                             //
  /////////////////////////////////////////////////////////////////
  
  // This is an example of a TIC TAC TOE via OSC.
  // It is BOTH receiving AND sending OSC messages.
  
  // This sketch represents the Player X (the one that draws crosses)

// create a 3 x 3 matrix
int xmax = 3;
int ymax = 3;
char[][] matrix = new char[xmax][ymax];

color fgColor = color(220, 200, 200);
color bgColor = color(200, 200, 200);
color hiColor = color(255, 200, 200);

// diameter of a stone
int dStone;

// text offset
int dText;

void setup() {
  
  size(300, 300);
  
  // diameter of one field of the matrix
  dStone = width / 3;
  dText =  dStone * 15 / 100;
  
  textSize(dStone);
  textAlign(CENTER);
  
  setupOSC();

}

void draw() {
  
  // medium gray
  background(127);

  // border around the fields
  int border = 1;
  
  // position of the active rectangle (the one the mouse is hovering over) 
  int activeX = getCol(mouseX, mouseY);
  int activeY = getRow(mouseY, mouseY);
      
  // Draw all fields of the matrix
  for(int x = 0; x < xmax; x++) {
    for(int y = 0; y < ymax; y++) {
      
      // hilight the rectangle if it's active
      fill(x == activeX && y == activeY ? hiColor : fgColor);
        
      // draw the rectangle
      int x0 = x*dStone + border;
      int y0 = y*dStone + border;
      int d0 = dStone - 2*border;
      rect(x0, y0, d0, d0); 
      
      // get the current stone
      char stone =  matrix[x][y];
      
      // if a stone has been set, draw it!
      if(stone != 0) {
        fill(50);
        text(stone, (x + .5) * dStone, (y + 1) * dStone - dText);
      }
      
    }
  }
 
}


// set a stone when the mouse is pressed
void mousePressed() {
      
    // calculate position of the current field
    int col = getCol(mouseX, mouseY);
    int row = getRow(mouseX, mouseY);

    setLocalO(col, row);
    setRemoteO(col, row);
        
}


// get the column for a screen position (value between 0 and 2)
int getCol(int x, int y) {
  return constrain(x/dStone, 0, 2);
}


// get row for a screen positon (value between 0 and 2)
int getRow(int x, int y) {
  return constrain(y/dStone, 0, 2); 
}


// clear the board when a key is pressed
void keyPressed() {
  clearLocalBoard();
  clearRemoteBoard();
}


void setLocalX(int x, int y) {
    // add an X to our own board
    matrix[x][y] = 'X';
}


void setLocalO(int x, int y) {
    // add an O to our own board
    matrix[x][y] = 'O';
}


void clearLocalBoard() {
  // create a new empty board
  matrix = new char[xmax][ymax];
}