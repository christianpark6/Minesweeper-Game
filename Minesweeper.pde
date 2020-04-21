boolean gameOver = false;
boolean Won = false;
int rectWidth;
int rectHeight;
//not open = 0 , open = -1, flag = 1
int [][] openCell =  new int [10][10] ;  //2D Array for my open cell.

int[][]mines =  new int [10][10];        // 2D array to place the mines.
//for (int row = 0; row < 10; row++) {
//   for (int col = 0; col <10; col++) {





//   }
//    }
void setup() {
  size (500, 500); 
  rectWidth  = width/10;
  rectHeight = height/10;
  textAlign(CENTER, CENTER);
  int i = 0; 
  while (i<10) {
    int x = (int)random(10);
    int y = (int)random(10);
    if (mines[x][y] == 0) {

      mines[x][y] = 10;
      i++;
    }
  }
  hints();
}
void hints() {      

  for (int row = 0; row<10; row++) {     //The input I use to make the 
                                         //program look at every box and create random bombs 
                                           //throughout the grid.
    for (int col= 0; col<10; col++) {
      if (mines[row][col] !=10) {
        int sum = 0;
        for (int r = row-1; r<= row+1; r++) {
          for (int c = col-1; c<= col +1; c++) {
            if (r>-1&&r<10 &&c>-1&&c<10) {
              if (mines[r][c]==10) {
                sum = sum+ 1;
              }
            }
          }
        }
        mines[row][col] = sum;
      }
    }


    for (int j = 0; j<mines.length; j++) {
      printArray(mines[j]);
    }
  }
}
void draw() {
  for (int i = 0; i<10; i++) {                                            //The input I use to create the colored boxes when opening the box.
    for (int j = 0; j<10; j++) {
      if (openCell[i][j] == -1) {
        fill(255);
        rect(i*rectWidth, j*rectHeight, rectWidth, rectHeight);
        fill(0);
        text(mines[i][j], i*rectWidth + rectWidth/2, j*rectHeight + rectHeight/2);
      } else if (openCell[i][j]==1) {

        fill(200);
        rect(i*rectWidth, j*rectHeight, rectWidth, rectHeight);
        fill(255, 0, 0);                                                    //This program also fills the box you flag with a red "f" so you are aware you flagged it.
        text("f", i*rectWidth + rectWidth/2, j*rectHeight + rectHeight/2);
      } else {
        fill(200);
        rect(i*rectWidth, j*rectHeight, rectWidth, rectHeight);               //This tells the program that every other box that isn't open is gray.
      }
    }
  }
  if (gameOver == true) {                                        //If the game is over and you lost this program will show text that says "GAMEOVER YOU LOST" in red text.
    fill(255, 0, 0);
    textSize(20);
    text("GAMEOVER", width/2, height/2);
    text("YOU LOST", width/2, height/2 + 30);
  }
  Won = checkWin();                                             //If you win the program will show text that says "CONGRATULATIONS YOU WON!" in red text as well.
  if (Won == true) {
    textSize(20);
    text("CONGRATULATIONS YOU WON!", width/2, height/2 + 30);
  }
}
void mousePressed() {
  int i = mouseX/rectWidth;                                //This helps create the function that means when the left button on the mouse is clicked it will open a cell.
  int j = mouseY/rectHeight;
  if (gameOver == false) {
    if (mouseButton == LEFT) {
      openCell[i][j] = -1;
      if (mines[i][j] == 0) 
      { 
        IntList X = new IntList(); 
        IntList Y = new IntList(); 
        X.append(i); 
        Y.append(j);
        while (X.size() > 0) {
          int row = X.remove(0);
          int col = Y.remove(0);
          for (int r = row-1; r<= row+1; r++) {
            for (int c = col-1; c<= col +1; c++) {
              if (r>-1&&r<10 &&c>-1&&c<10) {
                if (mines[r][c]==0 && openCell[r][c] == 0) {
                  X.append(r);
                  Y.append(c);
                }
                openCell[r][c] = -1;
              }
            }
          }
        }
      }

      if (mines[i][j] == 10) {
        gameOver = true;
      }
    } else if (mouseButton == RIGHT) {          //If you right click the mouse this will tell the program to leave a flag on the cell that the mouse is pressed on.
      if (openCell[i][j] == 1) { 
        openCell[i][j] = 0;
      } else {  
        openCell[i][j] = 1;
      }
    }
  }
}
boolean checkWin() {                                            //This tells the program that if all the bombs are flagged the game has been won.
  for (int row = 0; row<10; row++) {
    for (int col= 0; col<10; col++) {
      if (mines[row][col] == 10 && openCell[row][col] != 1) {
        return false;
      }
    }
  }
  return true;
}
