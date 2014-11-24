float minAlpha = 25;

class OBJ_LOADER {

  String[] zeilen;
  String fileName;

  ArrayList<P> ps;
  ArrayList<T> ts;

  int id;
  float alp = minAlpha;

  boolean active = false;

  OBJ_LOADER(String filename, int _id) {
    this.fileName = filename;
    zeilen = loadStrings(filename);
    this.id = _id;
  }

  OBJ_LOADER() {
  }

  void createPs() {
    ps = new ArrayList<P>();
    for (int i = 0; i < zeilen.length; i+=1) {
      String[] woerter = PApplet.split(zeilen[i], ' ');
      if (woerter[0].equals("v")) {
        int idx = 1;
        if (woerter[idx].equals("")) {
          idx++;
        }
        float x = Float.valueOf(woerter[idx++]);
        float y = Float.valueOf(woerter[idx++]);
        float z = Float.valueOf(woerter[idx++]);
        ps.add(new P(x, y, z));
      }
    }
  }


  void createTs() {
    ts = new ArrayList<T>();
    for (int i = 0; i < zeilen.length; i++) {
      if (zeilen[i].contains("f")) {
        String[] woerter = PApplet.split(zeilen[i], ' ');
        if (woerter[1].contains("/")) {
          String[] wort1 = PApplet.split(woerter[1], '/');
          String[] wort2 = PApplet.split(woerter[3], '/');
          String[] wort3 = PApplet.split(woerter[5], '/');
          int p1 = Integer.valueOf(wort1[0]) - 1;
          int p2 = Integer.valueOf(wort2[0]) - 1;
          int p3 = Integer.valueOf(wort3[0]) - 1;
          P t1_P = (P) ps.get(p1);
          P t2_P = (P) ps.get(p2);
          P t3_P = (P) ps.get(p3);
          ts.add(new T(t1_P.x, t1_P.y, t1_P.z, t2_P.x, t2_P.y, t2_P.z, t3_P.x, t3_P.y, t3_P.z));
        } 
        else {
          int p1 = Integer.valueOf(woerter[1]) - 1;
          int p2 = Integer.valueOf(woerter[2]) - 1;
          int p3 = Integer.valueOf(woerter[3]) - 1;
          P t1_P = (P) ps.get(p1);
          P t2_P = (P) ps.get(p2);
          P t3_P = (P) ps.get(p3);
          ts.add(new T(t1_P.x, t1_P.y, t1_P.z, t2_P.x, t2_P.y, t2_P.z, t3_P.x, t3_P.y, t3_P.z));
        }
      }
    }
  }

  void displayCircles() {
    stroke(60, alp);
    noFill();
    fill(0, alp/4);
    pushMatrix();
    rotateX(PI/2);
    //ellipse(0, 0, 200, 200);

    noFill();
    ellipse(0, 0, 20, 20);
    popMatrix();
  }


  void displayTs() {
    //noStroke();
    //stroke(100, alp);
    //fill(255, alp);
    for (int i = 0; i < ts.size(); i++) {
      T t_T = ts.get(i);
      t_T.display();
    }
  }

  void displayEngraving() {
    stroke(170, alp);
    noFill();
    strokeWeight(.5f);
    PVector P2 = new PVector();
    pushMatrix();
    for (int i = 0; i < 8; i++) {
      line(10, 0, 100, 0);
      for (float j = 11; j<100; j+=1) {
        PVector P1 = new PVector(j, 0);
        if (j%10==0) {
          P2 = new PVector(j + 1.5f, 0);
        }
        else {
          P2 = new PVector(j + 1f, 0);
        } 
        PVector g = PVector.sub(P2, P1);
        g.rotate(PI);
        pushMatrix();
        rotateX(PI/2);
        line(j, -g.x, j, g.x);
        popMatrix();
      }
      rotateY(radians(45));
    }
    popMatrix();
  }

  void select() {
    if (id == index) {
      active = true;
    }
    else {
      active = false;
    }
  }

  float salp() {
    float a = 0;
    if (active) {
      a = 255;
    }
    else {
      a = minAlpha;
    }
    return a;
  }

  void switchAlpha() {
    alp = alp + 0.065*(salp()-alp);
  }
}


void displayObjsTs() {
  pushMatrix();
  for (int i = 0; i < objs.size(); i++) {
    OBJ_LOADER o = (OBJ_LOADER)objs.get(i);
    translate(0, -10);
    fill(255, o.alp);
    noStroke();
    o.displayTs();
    stroke(255, o.alp);
    o.displayEngraving();
  }
  popMatrix();
}

void selectObjs() {
  for (int i = 0; i < objs.size(); i++) {
    OBJ_LOADER o = (OBJ_LOADER)objs.get(i);
    o.select();
  }
}

void smoothObjs() {
  for (int i = 0; i < objs.size(); i++) {
    OBJ_LOADER o = (OBJ_LOADER)objs.get(i);
    o.switchAlpha();
  }
}

void displayFlatShapes(){
for (int i = 0; i < objs.size(); i++) {
    OBJ_LOADER o = (OBJ_LOADER)objs.get(i);
    fill(255, o.alp);
    noStroke();
    o.displayTs();
    stroke(170, o.alp);
    o.displayEngraving();
  }
}

