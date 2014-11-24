class T {


  PVector P1, P2, P3;
  int id;
  boolean intersect = false;

  T(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3) {
    P1 = new PVector(x1, y1, z1);
    P2 = new PVector(x2, y2, z2);
    P3 = new PVector(x3, y3, z3);
  }

  void display() {
    beginShape(TRIANGLES);
    vertex(P1.x, P1.y, P1.z);
    vertex(P2.x, P2.y, P2.z);
    vertex(P3.x, P3.y, P3.z);
    endShape();
  }
}



