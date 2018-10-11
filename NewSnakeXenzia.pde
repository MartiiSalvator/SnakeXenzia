//Aaron Duc Nguyen
// 10/11/2018



ArrayList<Float> x, y;

final int up = 1, down = 2, left = 3, right = 4;
int direction = right;
boolean move = false;
int n = 6;
final float distance = 10.0;
int hit = 0;
final int Game_over = 0, Game_on = 1;
int mode = 1, point = 0;
float appleX, appleY;

void setup() {
  background(255);
  size(300, 300);
  smooth();

  x = new ArrayList<Float>();
  y = new ArrayList<Float>();

  x.add(50.0);
  y.add(50.0);

  for (int i = 1; i < n; i++) {
    x.add(x.get(0)-i*distance);
    y.add(y.get(0) );
  }
  locateApple();
  createSnake();
}

void draw() {
  if (mode == Game_over) background(0);
  else if (mode == Game_on) {
    background(0);
    frameRate(10);
    showGoal();

    //food

    createApple();

    if (dist(x.get(x.size()-1), y.get(y.size()-1), appleX, appleY) < distance) {
      point += 20;
      addTail();
      locateApple();
      println(point);
    }

    //the snake
    relocateSnake();
    createSnake();
    for (int i = 0; i < n - 2; i++) {
      if (dist(x.get(i), y.get(i), x.get(n-1), y.get(n-1)) < distance) {
        hit +=1;
      }
    }

    //println(hit);

    if (hit > 6) {
      println("GAME OVER");
      mode = Game_over;
      hit = 6;
    }
  }
}


//locate the food
void locateApple() {
  appleX = random(width-distance);
  appleY = random(height-distance);
}
//create the food
void createApple() {
  fill(255, 0, 0, random(50, 200));
  ellipse(appleX, appleY, distance, distance);
}

//create the snake
void createSnake() {
  fill(255, 255, 0);
  for (int i = 0; i < n; i++) {
    float xLocation = x.get(i);
    float yLocation = y.get(i);

    if (xLocation > width ) x.set(i, 0.0); 
    if (xLocation < 0) x.set(i, 300.0);

    if (yLocation >= height) y.set(i, 0.0);
    if (yLocation <= 0) y.set(i, 300.0);

    ellipse(xLocation, yLocation, distance, distance);
  }
}


void relocateSnake() {

  if (direction == right) {
    x.add(x.get(x.size()-1)+distance);
    y.add(y.get(y.size()-1));

    x.remove(0);
    y.remove(0);
  } else if (direction == down) {
    x.add(x.get(x.size()-1));
    y.add(y.get(y.size()-1)+distance);

    x.remove(0);
    y.remove(0);
  } else if (direction == left) {
    x.add(x.get(x.size()-1)-distance);
    y.add(y.get(y.size()-1));

    x.remove(0);
    y.remove(0);
  } else if (direction == up) {
    x.add(x.get(x.size()-1));
    y.add(y.get(y.size()-1)-distance);

    x.remove(0);
    y.remove(0);
  }
}

//add tail of the snake
void addTail() {
  n += 1;

  switch(direction) {
  case up:
    x.add(x.get(x.size()-1));
    y.add(y.get(y.size()-1)-distance);
    n = x.size();
    break;

  case down:
    x.add(x.get(x.size()-1));
    y.add(y.get(y.size()-1)+distance);
    n = x.size();
    break;

  case left:
    x.add(x.get(x.size()-1)-distance);
    y.add(y.get(y.size()-1));
    n = x.size();
    break;

  case right:
    x.add(x.get(x.size()-1)+distance);
    y.add(y.get(y.size()-1));
    n = x.size();
    break;
  }
}

//void mouseClicked() {
//  n = n+1;
//  addTail();
//}

void keyPressed() {

  if (mode == Game_on) {
    if (direction == right) {
      if (key == 'w') direction = up;
      if (key == 's') direction = down;
      if (key == 'd') direction = right;
    }
    if (direction == left) {
      if (key == 'w') direction = up;
      if (key == 's') direction = down;
      if (key == 'a') direction = left;
    }
    if (direction == up) {
      if (key == 'w') direction = up;
      if (key == 'a') direction = left;
      if (key == 'd') direction = right;
    }
    if (direction == down) {
      if (key == 's') direction = down;
      if (key == 'a') direction = left;
      if (key == 'd') direction = right;
    }
  } else if (mode == Game_over) {
    if (key == 'x') {
      exit();
      //mode = Game_on;
    }
  }
}


//reset the game 
void reset() {

  n = 6;

  x.add(50.0);
  y.add(50.0);
  for (int i = 1; i < n; i++) {
    x.add(x.get(0)-i*distance);
    y.add(y.get(0) );
  }

  createSnake();
}

//show your goal

void showGoal() {
  textSize(15);
  fill(0, 255, 0, 100);
  text("score: " + point, 50, 50);
}
