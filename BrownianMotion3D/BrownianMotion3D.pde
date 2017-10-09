int range = 13;
final int TOTAL_NUM_OF_LIST = 100;
final int resolutionX = 1440; 
final int resolutionY = 1440;
final int resolutionZ = 900;
float rotation=0;


class Coordinate2d {        // Class --> Reference
  float x;
  float y;
  float z;

  Coordinate2d(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  float getX() {
    return this.x;
  }  
  float getY() {
    return this.y;
  }
  float getZ() {
    return this.z;
  }
  void setX(float x)
  {
    this.x = x;
  }
  void setY(float y)
  {
    this.y = y;
  }
  void getZ(float z) 
  {
    this.z = z;
  }
}

ArrayList<ArrayList<Coordinate2d>> coordinatesList = new ArrayList<ArrayList<Coordinate2d>>();      // ArrayListExample ----> Reference & Mr. Livesay
ArrayList<Integer> colors = new ArrayList<Integer>();

void setup() 
{
  size(1440, 900, P3D);
  frameRate = 1;

 
  for (int i = 0; i < TOTAL_NUM_OF_LIST; i++ ) {
    coordinatesList.add(new ArrayList<Coordinate2d>());
    float originX = random(0, resolutionX);
    float originY = random(0, resolutionY);
    float originZ = random(0, resolutionZ);
    coordinatesList.get(i).add(new Coordinate2d(originX, originY, originZ));

    float randomRgbColor = color(random(0, 255), random(0, 255), random(0, 255));        // color ---> processing.org/reference
    colors.add((int)randomRgbColor);
  }
}

void draw()
{
  background(15);
  if (rotation < 650) 
  {                                                      // Orbit <---- Examples on google
    float orbitRadius= resolutionX/2;
    float position_of_Y= resolutionY/2;
    float position_of_X= cos(radians(rotation))*orbitRadius;
    float position_of_Z= sin(radians(rotation))*orbitRadius;
    camera(position_of_X, position_of_Y, position_of_Z, width, height, 10, 3, 10, -5);
    rotation++;                                         // Orbit <---- Examples on Google
  } else
  {    
    camera(mouseX, mouseY, (width/2) / tan(PI/9), width/2, height/2, 5, 10, -5, 0);          // Camera ----> processing.org/reference
  }

  for ( int i = 0; i < TOTAL_NUM_OF_LIST; i++ ) {
    stroke(colors.get(i));
    float delta_x = random(-range, range);
    float delta_y = random(-range, range);
    float delta_z = random(-range, range);
    ArrayList<Coordinate2d> coordinates = coordinatesList.get(i);
    int lastIndexOfPreviousCoordinate = coordinates.size() - 1;
    float newX = coordinates.get(lastIndexOfPreviousCoordinate).getX() + delta_x;
    float newY = coordinates.get(lastIndexOfPreviousCoordinate).getY() + delta_y;
    float newZ = coordinates.get(lastIndexOfPreviousCoordinate).getZ() + delta_z;
    Coordinate2d newCoordinate = new Coordinate2d(newX, newY, newZ); 
    coordinates.add(newCoordinate);

    for (Coordinate2d coordinate : coordinates) {

      point(coordinate.getX(), coordinate.getY(), coordinate.getZ());
    }
  }
}