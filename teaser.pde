import processing.opengl.*;

ArrayList objs = new ArrayList<OBJ_LOADER>();
int index = 0;
boolean rot = true; //toggle with spacebar
float angle=0;
float fov, cameraZ;

float rotX = -25;
float sRotX=-35;
float zoom = 2.5;
float yPos;

void setup() {
  size(1280, 700, OPENGL);

  for (int i = 0; i< 10; i++) {
    OBJ_LOADER o = new OBJ_LOADER("g"+(i)+".obj", i);
    o.createPs();
    o.createTs();
    objs.add(o);
  }
  yPos = height/1.65;
  fov = PI/6.0;
  cameraZ = (height/2.0) / tan(fov/2);
}

void draw() {

  if (rot) angle+=.2;
  if (angle>360) angle=0;
  selectObjs();
  smoothObjs();

  yPos = map(rotX, 0, -90, height/1.5, height/2);
  index = int(map (mouseY, 150, height-150, 9, 0));

  background(0);
  lights();
  hint(ENABLE_DEPTH_TEST);
  //perspective(fov, width/height, cameraZ/40.0, cameraZ*40.0);
  perspective();
  pushMatrix();
  translate(width/2.5, yPos);
  rotateX(radians(rotX));
  rotateY(radians(angle));
  scale(zoom);
  displayObjsTs();
  popMatrix();

  hint(DISABLE_DEPTH_TEST);
  pushMatrix();
  translate(width-300, height/1.75);
  rotateX(PI/2);
  scale(1.5);
  displayFlatShapes();
  popMatrix();
}

void keyPressed() {
  if (keyCode == UP) {
    rotX+=5;
  }
  if (keyCode == DOWN) {
    rotX-=5;
  }
  if (key == ' ') {
    rot = !rot;
  }

  if (keyCode == LEFT) zoom -=.1f;
  if (keyCode == RIGHT) zoom +=.1f;

  //println(index);
}

