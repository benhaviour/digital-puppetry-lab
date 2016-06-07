  
  ///////////////////////////////////////////////
  //                                           //
  //    T W I N    S P H E R E S               //
  //                                           //
  ///////////////////////////////////////////////

// Connecting to the Captury using osc-proxy.pd

import peasy.*;
import netP5.*;
import oscP5.*;

OscP5 osc;
NetAddress remote;
PeasyCam cam;

int localport = 12000;
int remoteport = 1065;
boolean debug = true;

color[] palette = {
  color(100),
  color(255, 100, 100),
  color(100, 100, 255),
  color(255)
};

// objects in space
Sphere sphere1, sphere2;

String skeleton1 = "Asha-neon-green-socks";
String bone1 = "Root";

String skeleton2 = "Martin-left-red-right-violet";
String bone2 = "Root";

// depth of the screen
int depth;

void setup() {

  fullScreen(P3D);
  // size(600, 600, P3D);
  
  sphereDetail(12);
  
  // create two sphere objects
  sphere1 = new Sphere(palette[1]);
  sphere2 = new Sphere(palette[2]);
  
  depth = width;
  
  // create a virtual camera
  cam = new PeasyCam(this, depth);
  
  // connect via OSC
  osc = new OscP5(this, localport);
  remote = new NetAddress("kosmos.medien.uni-weimar.de", remoteport);
  setPort(localport);

  // pass position of Asha's root bone to the first sphere object
  plugBone(sphere1, skeleton1, bone1);
  
  // pass position of Martin's root bone to the seconds object
  plugBone(sphere2,skeleton2, bone2);
  
  // subscribe to OSC
  refreshSubscriptions();

}


// update the subscriptions to make sure they don't expire
void refreshSubscriptions() {
  subscribeBone(skeleton1, bone1);
  subscribeBone(skeleton2, bone2);
}


void draw() {

  background(palette[0]);
  
  // lights for 3D effect
  lights();
 
  // draw a 6 x 6 grid for the floor
  fill(palette[3]);
  drawGrid(6, 6, width, width);
  
  // draw the spheres
  sphere1.draw();
  sphere2.draw();
  
  // refresh subscription every second or so
  if (frameCount % 10 == 0) {
    refreshSubscriptions();
  }
  
}


// draw an m x n grid
void drawGrid(int m, int n, float width, float height) {

  float dx = width / m;
  float dy = height / n;
  float gap = min(dx, dy) / 20;
  
  pushMatrix();
  for(int y = 0; y < n; y++) {
      for(int x = 0; x < m; x++) {
        float x1 = -width/2 + map(x, 0, m, 0, width);
        float y1 = -height/2 + map(y, 0, n, 0, height);
        rect(x1 + gap, y1 + gap, dx - 2 * gap, dy - 2 * gap);
      }
  }
  popMatrix();
 
}


// capture all OSC events
void oscEvent(OscMessage msg) {
  if(debug) {
    print("### received an osc message.");
    print(" addrpattern: "+msg.addrPattern());
    println(" typetag: "+msg.typetag());
  }
}


// plug a specific bone
void plugBone(Object target, String skeleton, String bone) {
  String path =  "/" + skeleton + "/blender/" + bone + "/vector";
  osc.plug(target, "update" + bone, path);
}


// let the captury know which port is our local port
void setPort(int port) {
  OscMessage msg = new OscMessage("/configure/port");
  msg.add(port); 
  osc.send(msg, remote);
}


// subscribe to a specific bone
void subscribeBone(String skeletonId, String bone) {
  OscMessage msg = new OscMessage("/subscribe/" + skeletonId + "/blender/" + bone + "/vector");
  msg.add(50.0);
  msg.add(0.0);
  msg.add(100.0);
  osc.send(msg, remote);
}