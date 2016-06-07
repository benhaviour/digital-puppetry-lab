
  /////////////////////////////////////////////////////////////////
  //                                                             //
  //     F A C E     O S C     R E C E I V E R                   //
  //                                                             //
  /////////////////////////////////////////////////////////////////
  
  // Path:    /face/id
  // Format:  ffff
  // Fields:  x1, y1, x2, y2 (coords of upper left corner, and lower light corner)
  
import netP5.*;
import oscP5.*;

OscP5 oscP5;

// array for face coords
int n = 10;
int[][] faces = new int[n][4];

// activity of the faces
float[] activity = new float[n];

// limits for received values
int xmin = 0;
int ymin = 0;
int xmax = 320;
int ymax = 240;

color bgcolor = color(0);
color fgcolor = color(255);

// color palette
color[] palette = {
  color(100, 0, 0),
  color(0, 100, 0),
  color(0, 0, 100),
  color(100, 100, 100) 
};

// Name or IP of the target machine
String remote_machine = "localhost";

// Port of the target machine
int remote_port = 13000;
int local_port = 12000;

void setup() {  
  size(960, 720);
  oscP5 = new OscP5(this, local_port);
  oscP5.plug(this, "faceEvent","/face");
  ellipseMode(CORNER);
  smooth(8);
}

void draw() {
  
  fill(bgcolor, 20);
  noStroke();
  rect(0, 0, width, height);
  
  for(int i = 0; i < n; i++) {
    
    activity[i] = max(0.0, activity[i] - 0.01);
    
    color c1 = palette[i % palette.length];
    color c2 = lerpColor(c1, fgcolor, 0.2);
    

    strokeWeight(8);
    fill(c1, activity[i] * 255);
    stroke(c2, activity[i] * 255);

    float x1 = map(faces[i][0], xmin, xmax, 0, width);
    float y1 = map(faces[i][1], ymin, ymax, 0, height);
    float x2 = map(faces[i][2], xmin, xmax, 0, width);
    float y2 = map(faces[i][3], ymin, ymax, 0, height);
    
    ellipse(x1, y1, x2, y2);
    
  }
}

public void faceEvent(int id, int x1, int y1, int x2, int y2) {
  println ("face ", id);
  if(id < n) {
    faces[id][0] = x1;
    faces[id][1] = y1;
    faces[id][2] = x2;
    faces[id][3] = y2;
    activity[id] = 1.0;
  }
}