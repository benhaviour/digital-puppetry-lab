
  /////////////////////////////////////////////////////////////////
  //                                                             //
  //     M O U S E     O S C     R E C E I V E R                 //
  //                                                             //
  /////////////////////////////////////////////////////////////////
  
  // OSC-Receiver using Mouse Input
  
  // OSC MESSAGES:
  
  // Path:    /mouse/down
  // Format:  b
  // Fields:  state
  
  // Path:    /mouse/moved
  // Format:  ii
  // Fields:  mouseX, mouseY
  
import netP5.*;
import oscP5.*;

OscP5 oscP5;

// input resolution
int xmin = 320, h = 240;

// Name or IP of the target machine
String remote_machine = "localhost";

// Port of the target machine
int remote_port = 13000;
int local_port = 12000;

NetAddress remote;

boolean remoteMouseDown = false;
int remoteMouseX = 0;
int remoteMouseY = 0;
int pRemoteMouseX = 0;
int pRemoteMouseY = 0;

void setup() {
  
  background(255);
  
  // colorful colors
  colorMode(HSB);
  
  // output screen
  size(320, 240);

  // create osc connection
  oscP5 = new OscP5(this, local_port);
  
  // route some osc events
  oscP5.plug(this, "remoteMouseDown","/mouse/down", "i");
  oscP5.plug(this, "remoteMouseMoved","/mouse/moved", "ii");
  
}

void draw() {
  
  // distance between current and previous mouse position
  float d =  dist(pRemoteMouseX, pRemoteMouseY, remoteMouseX, remoteMouseY);
  
  //black outline
  strokeWeight(d);
  stroke(0);
  line(pRemoteMouseX, pRemoteMouseY, remoteMouseX, remoteMouseY);
    
  // colorful inline
  strokeWeight(d/2);
  stroke(frameCount * 5 % 360, 127, 255);
  line(pRemoteMouseX, pRemoteMouseY, remoteMouseX, remoteMouseY);
  
}

void remoteMouseMoved(int x, int y) {
  pRemoteMouseX = remoteMouseX;
  pRemoteMouseY = remoteMouseY;
  remoteMouseX = x;
  remoteMouseY = y;
}

void remoteMouseDown(int state) {
  remoteMouseDown = state > 0;
}