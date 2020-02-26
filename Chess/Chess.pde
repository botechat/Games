PImage Pawn, Bishop, Knight, Rook, Queen, King, Empty;
PFont f;
int[][] table = new int[9][9];
int[][] cores = new int[9][9];
boolean click = false;
boolean check = false;
boolean check1 = false;
int firstTime = 0;
int  x1 = 0;
int  x2 = 0; 
int  y1 = 0;
int  y2 = 0;
float randNum1,randNum2;
char randOperation;
float result;
void setup() {
  f = createFont("Arial",20,true);
  background(51, 255, 204);
  size(800, 800);
  Empty = loadImage("/Chess Pieces/sparkle-png-sparkle-png-photos-400.png");
  Pawn = loadImage("/Chess Pieces/22266-chicken-icon.png");
  Bishop = loadImage("/Chess Pieces/elephant.png");
  Knight = loadImage("/Chess Pieces/Horse.png");
  Rook = loadImage("/Chess Pieces/Giraffe.png");
  Queen = loadImage("/Chess Pieces/Fox-PNG-10.png");
  King = loadImage("/Chess Pieces/Lion.png");
  int x = 0;
  int y = 0;
  Table(x, y);
  imageMode(CORNERS);
  //if it`s in the n column -> it`s between (n-1)*100 and n*100.  The same applies to the rows.
  Begin();
}

void draw() {
  background(255);
  int x = 0;
  int y = 0;
  Table(x, y);
  Pieces();
}


void Table(int x, int y) {
  for (int i = 0; i < 8; i++) {
    line(x, 0, x, 800);
    x += 100;
  }
  for (int i = 0; i < 9; i++) {
    line(0, y, 800, y);
    y += 100;
  }
}

void Begin() {
  //Black
  for (int i = 1; i < 9; i++) {
    for (int j = 1; j < 3; j++) {
      cores[i][j] = 1;
    }
  }
  table[4][1] = 1;
  for (int i = 1; i < 9; i++) { //Black Pawns
    table[i][2] = 3;
  }

  table[5][1] = 2;
  table[3][1] = 4;
  table[6][1] = 4;
  table[2][1] = 5;
  table[7][1] = 5;
  table[1][1] = 6;
  table[8][1] = 6;

  //White
  for (int i = 1; i < 9; i++) {
    for (int j = 7; j < 9; j++) {
      cores[i][j] = 0;
    }
  }
  table[4][8] = 1;
  for (int i = 1; i < 9; i++) { //White Pawns
    table[i][7] = 3;
  }

  table[5][8] = 2;
  table[3][8] = 4;
  table[6][8] = 4;
  table[2][8] = 5;
  table[7][8] = 5;
  table[1][8] = 6;
  table[8][8] = 6;
  for (int a = 1; a < 9; a++) {
    for (int b = 1; b < 9; b++) {
      if (table[a][b] != 1 && table[a][b] != 2 && table[a][b] != 3 && table[a][b] != 4 && table[a][b] != 5 && table[a][b] != 6) {
        table[a][b] = 0;
        cores[a][b] = 2;
      }
    }
  }
}
void Pieces() {
  for (int i = 1; i < 9; i++) {
    for (int j = 1; j < 9; j++) {
      if (cores[i][j] == 0 || cores[i][j] == 2) { //White
        fill(255);
        rect(i*100 - 100, j*100 - 100, i*100,j*100);
      }
      if (cores[i][j] == 1) { //Black
        fill(0);
        rect(i*100 - 100, j*100 - 100, i*100,j*100);
      }

      if (table[i][j] == 0) { //Empty
        image(Empty, 100*i - 100, 100*j - 100, 100*i, 100*j);
      } else if (table[i][j] == 1) { //King
        image(King, 100*i - 100, 100*j - 100, 100*i, 100*j);
      } else if (table[i][j] == 2) { //Queen
        image(Queen, 100*i - 100, 100*j - 100, 100*i, 100*j);
      } else if (table[i][j] == 3) { //Pawn
        image(Pawn, 100*i - 100, 100*j - 100, 100*i, 100*j);
      } else if (table[i][j] == 4) { //Bishop
        image(Bishop, 100*i - 100, 100*j - 100, 100*i, 100*j);
      } else if (table[i][j] == 5) { //Knight
        image(Knight, 100*i - 100, 100*j - 100, 100*i, 100*j);
      } else if (table[i][j] == 6) { //Rook
        image(Rook, 100*i - 100, 100*j - 100, 100*i, 100*j);
      }
    }
  }
}
void checkMoveColor(int x1, int y1, int x2, int y2){
  if(cores[x1][y1] == 0 && cores[x2][y2] == 1){
    check = true;
  }
  else if(cores[x1][y1] == 0 && cores[x2][y2] == 0){
    check = false;
  }
  else if(cores[x1][y1] == 0 && cores[x2][y2] == 2){
    check = true;
  }
  else if(cores[x1][y1] == 1 && cores[x2][y2] == 1){
    check = false;
  }
  else if(cores[x1][y1] == 1 && cores[x2][y2] == 0){
    check = true;
  }
  else if(cores[x1][y1] == 1 && cores[x2][y2] == 2){
    check = true;
  }
  else if(cores[x1][y1] == 2){
    check = false;
  }
}

/*void checkMove(int x1, int y1, int x2, int y2){
 if(table[x1][y1] == 0){ //Empty
   check1 = false;
 }
 else if(table[x1][y1] == 1){ //King
   if(y2 == y1-1 && x2 == x1){ //acima
     check1 = true;
   }
   else if(y2 == y1-1 && x2 == x1+1){ //diagonal direita cima
     check1 = true;
   }
   else if(y2 == y1 && x2 == x1+1){ //direita
     check1 = true;
   }
   else if(y2 == y1+1 && x2 == x1+1){ //diagonal direita baixo
     check1 = true;
   }
   else if(y2 == y1+1 && x2 == x1){ //embaixo
     check1 = true;
   }
   else if(y2 == y1+1 && x2 == x1-1){ //diagonal esquerda baixo
     check1 = true;
   }
   else if(y2 == y1 && x2 == x1-1){ //esquerda
     check1 = true;
   }
   else if(y2 == y1-1 && x2 == x1-1){ //diagonal esquerda cima
     check1 = true;
   }
   else{
     check1 = false;
   }
 }
 else if(table[x1][y1] == 3 && cores[x2][y2] == 2){ //Pawn when moving
   if(cores[x1][y1] == 1){ //preto
     if(firstTime == 0 || firstTime == 1){
       if(y2 == y1+2 && x2 == x1){
         check1 = true;
         firstTime++;
       }
       else if(y2 == y1+1 && x2 == x1){
         check1 = true;
     }
       else{
         check1 = false;
     }
     }
     else{
     if(y2 == y1+1 && x2 == x1){
       check1 = true;
     }
     else{
       check1 = false;
     }
   }
   }
   
   else if(cores[x1][y1] == 0){ //branco
   if(firstTime == 0 || firstTime == 1){ //se this thing
       if(y2 == y1-2 && x2 == x1){
         check1 = true;
         firstTime++;
       }
       else if(y2 == y1+1 && x2 == x1){
         check1 = true;
     }
       else{
         check1 = false;
     }
     }
     else{
     if(y2 == y1-1 && x2 == x1){
       check1 = true;
     }
     else{
       check1 = false;
     }
   }
 }
}

  else if(table[x1][y1] == 3 && (cores[x2][y2] == 1 || cores[x2][y2] == 0)){ //Pawn when capturing
    if(cores[x1][y1] == 0){
      if(y2 == y1 - 1 && x2 == x1 - 1){
        check1 = true;
      }
      else if(y2 == y1 - 1 && x2 == x1 + 1){
        check1 = true;
      }
      else{
        check1 = false;
      }
    }
    else if(cores[x1][y1] == 1){
      if(y2 == y1 + 1 && x2 == x1 - 1){
        check1 = true;
      }
      else if(y2 == y1 + 1 && x2 == x1 + 1){
        check1 = true;
      }
      else{
        check1 = false;
      }
    }
}
}*/
void mousePressed() {
  int piece1x, piece1y, piece2x, piece2y;
  piece1x = 0;
  piece1y = 0;
  piece2x = 0;
  piece2y = 0;
  if (click == false) {
    x1 = mouseX;
    y1 = mouseY;
  } else {
    x2 = mouseX;
    y2 = mouseY;
  }
if(click == true){
  for (int i = 1; i < 9; i++) {
    for (int j = 1; j < 9; j++) {
      if (x1 > (i-1) * 100 && x1 < i * 100 && y1 > (j-1)*100 && y1 < j*100) {
        piece1x = i;
        piece1y = j;
      }
    }
  }
  for (int i = 1; i < 9; i++) {
    for (int j = 1; j < 9; j++) {
      if (x2 > (i-1) * 100 && x2 < i * 100 && y2 > (j-1)*100 && y2 < j*100) {
        piece2x = i;
        piece2y = j;
      }
    }
  }
  randomExpression();
  checkMoveColor(piece1x,piece1y,piece2x,piece2y);
  //checkMove(piece1x,piece1y,piece2x,piece2y);
  if(check == true /*&& check1 == true*/){
    table[piece2x][piece2y] = table[piece1x][piece1y];
    cores[piece2x][piece2y] = cores[piece1x][piece1y];
    table[piece1x][piece1y] = 0;
    cores[piece1x][piece1y] = 2;
    click =! click;
  }
  else{
    click = false;
  }
}
else{
  click =! click;
}
}

void randomExpression(){
  float temporary;
  randNum1 = random(0,40);
  randNum2 = random(0,40);
  temporary = random(1,5);
  
  if(floor(temporary) == 1){
    randOperation = '+';
    result = floor(randNum1) + floor(randNum2);
  }
   else if(floor(temporary) == 2){
     randOperation = '-';
     result = floor(randNum1) - floor(randNum2);
  }
   else if(floor(temporary) == 3){
     randOperation = '*';
     result = floor(randNum1) * floor(randNum2);
  }
   else if(floor(temporary) == 4){
     randOperation = '/';
     result = floor(randNum1) / floor(randNum2);
  }
}

void printExpression(){
  while(true){
  int a = 200;
  textFont(f);
  text(randNum1,a,height/2);
  a += textWidth((char)randNum1) + 50; 
  text(randOperation,a,height/2);
  a += textWidth(randOperation) + 50; 
  text(randNum2,a,height/2);
  a += textWidth((char)randNum2) + 50; 
}
}
