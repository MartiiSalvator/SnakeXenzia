ArrayList<Float> x, y;

final int up = 1, down = 2, left = 3, right = 4;
int direction = right;
boolean move = false;
int n = 4;
final float distance = 10.0;

void setup() {
  background(0);
  size(1000, 1000);

  x = new ArrayList<Float>();
  y = new ArrayList<Float>();

  x.add(100.0);
  y.add(500.0);

  for (int i = 1; i < n; i++) {
    x.add(x.get(0)-i*distance);
    y.add(y.get(0) );
  }

  println(x, y);
  createSnake();
}

void draw() {

  background(0);
  frameRate(15);

  relocateSnake();
  createSnake();
  
  println(x,y);
}


void createSnake() {
  fill(255, 255, 0);
  for (int i = 0; i < n; i++) {
    float xLocation = x.get(i);
    float yLocation = y.get(i);
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

  //println(x, y);
}

//add tail of the snake
void addTail() {

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

void mouseClicked() {
  n = n+1;
  addTail();
}

void keyPressed() {
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
}
