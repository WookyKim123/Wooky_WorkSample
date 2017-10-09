// Variables that will be used to control the position and speed of ball
int x = 400 + int(random(-80, 80));
int y = 350; 
int speedOfBallGoingInXDirection = 5;
int speedOfBallGoingInYDirection = -5;


//Creationg of Plate
int width_of_plate = 200;
int x_plate = 500;
int y_plate = 670;
int PLATE_SPEED = 25;

// Scores 
int level = 1;
int score = 0;
int wait = 0;

int x_corner = 50;
int y_corner = 20;
int brickWidth = 100;
int brickHeight = 40;
int blockPerRow = 10;
int brickHalfWidth = brickWidth/2;
int brickHalfHeight = brickHeight/2;
int totalBricks = 20;

int bgColor = 0;
int ballColor = #FF0000;
int plateColor = #00FF00;
int brickColor = #0000FF;

class GameInfo {
  static final int BRICK_HIT_SCORE = 5;
  static final int PLATE_HIT_SCORE = 1;
  int score = 0;
  int level = 1;
  
  void applyPlateHitScoring() {
    this.score += PLATE_HIT_SCORE;
  }
  
  void applyBrickHitScoring() {
    this.score += BRICK_HIT_SCORE;
  }
}

class Point2D {
  int x;
  int y;
}

class Brick {
  Point2D cornerCoordinate;
  boolean isBroken;
  int _width;
  int _height; 
  int brickColor; // 0 - 255
  
  Brick(int x_corner, int y_corner, int _width, int _height, int brickColor) {
    Point2D newPoint = new Point2D();
    newPoint.x = x_corner;
    newPoint.y = y_corner;
    
    this.cornerCoordinate = newPoint;
    this._width = _width;
    this._height = _height;
    this.brickColor = brickColor;
  }
  
  void breakBrick() {
    this.isBroken = true;
  }
  
  boolean isExist() {
    return !this.isBroken;
  }
  
  boolean isBroken() {
    return this.isBroken;
  }
}

Brick[] bricks = new Brick[20];
GameInfo gameInfo = new GameInfo();

void setup() {
  size(1000, 700);
  rectMode(CORNER);
    
  // Calculate the x,y position of upper right corner of each and every brick
  for (int i = 0; i < 20; i++) {
    x_corner = brickWidth  * (i % 10)  ;
    y_corner = brickHeight * ((i / blockPerRow));
    int randomBrickColor = (int)color(random(0,255), random(0,255), random(0,255));
    Brick brick = new Brick(x_corner, y_corner, brickWidth, brickHeight, randomBrickColor);
    bricks[i] = brick;
  }
}

void printOutBricks() {
  for (int i = 0 ; i < 20 ; i++) {
       println("brick[" + i + "]");
       println(bricks[i].cornerCoordinate.x);
       println(bricks[i].cornerCoordinate.y);
       println(bricks[i].brickColor);
       println(bricks[i].isExist());
    }
}

void keyPressed() {
  if (keyCode == RIGHT ) {
    // Move paddle right
    x_plate = x_plate + PLATE_SPEED;
  } else if (keyCode == LEFT) {
    // Move paddle left
    x_plate = x_plate - PLATE_SPEED;
  } else if (keyCode == ' ') {
      x = 250;
      y = 350;
      speedOfBallGoingInXDirection = 3;
      speedOfBallGoingInYDirection = -3;
      x_plate = 250;
      score = 0;
      level = 1;
      Brick[] bricks = new Brick[20];
}  
}

boolean checkBrickCollision(Brick brick, int x, int y) {
  boolean isCollide = 
  (
      ((brick.cornerCoordinate.x) < x && (brick.cornerCoordinate.x + brick._width) > x)
       &&
      ((brick.cornerCoordinate.y) < y && (brick.cornerCoordinate.y + brick._height) > y)
  );
  println("isCollide = " + isCollide);
  return isCollide;
}


void drawScoreBoard() {
  //scoreboard
  textSize(20);
  textAlign(RIGHT);               //processing.org/reference
  text("Score:", 65, 690);     //"Score" and its coordinate
  text(gameInfo.score, 90, 690);

  //textAlign(LEFT);
  //text("Level:", 850, 690);
  //textAlign(RIGHT);
  //text(gameInfo.level, 930, 690);
}

void checkGameOver() {
if (y > height) {
    textSize(40);
    textAlign(CENTER);
    text("Game over", width/2, height/2);
  }
}

void draw() {
  background(bgColor);
  /* draw score board */
  drawScoreBoard();
  
  /* drawing the ball */
  fill(ballColor);
  ellipse(x, y, 15, 15);
  x = x + speedOfBallGoingInXDirection;
  y = y + speedOfBallGoingInYDirection;
  
  fill(plateColor);
  /* draw plate */ 
  rect(x_plate, y_plate, width_of_plate, 20);
  
  /* COLLISION CHECK : plate and ball */
  if ((x_plate-width_of_plate)<x && (x_plate+width_of_plate)>x &&      // Ball collision with the paddle <----- MR. Livesay
    (y_plate-10)<y && (y_plate)>y) {
    speedOfBallGoingInYDirection = -speedOfBallGoingInYDirection;      // The ball hits the rectangular plate. In order to just simply "imitate" the bouncing effect I reversed the speed of the ball going in the y direction. 
    gameInfo.applyPlateHitScoring();
  }
   
  /* COLLISION CHECK : left and right wall */
  if (x > width || x < 0)                    // IF the value of x becomes greater than the width, reverse the speed of ball going in the direction. This makes the collision phenomenon. 
    speedOfBallGoingInXDirection = -speedOfBallGoingInXDirection;
  
  /* COLLISION CHECK : top wall */
  if (y < 0) {
    speedOfBallGoingInYDirection = -speedOfBallGoingInYDirection;
  }
  
  /* draw bricks */
  for (int i=0; i< totalBricks; i++) { 
    // Check if we we have a block (bricks[x] is 1)
    Brick currentBrick = bricks[i];
    if (currentBrick.isExist()) {
      if ( checkBrickCollision(currentBrick, x, y)) {
        speedOfBallGoingInYDirection = -speedOfBallGoingInYDirection;
        currentBrick.breakBrick();
        gameInfo.applyBrickHitScoring();
      }
      /* Draw the brick */
      fill(bricks[i].brickColor);
      rect(bricks[i].cornerCoordinate.x, bricks[i].cornerCoordinate.y, bricks[i]._width, bricks[i]._height); // !!!!
    }
  }
  
  /* check game over */
  checkGameOver();
}