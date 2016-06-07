
  /////////////////////////////////////////////////////////////////
  //                                                             //
  //     M O U S E     O S C     S E N D E R                     //
  //                                                             //
  /////////////////////////////////////////////////////////////////
  
  // OSC-Sender using Mouse Input
  
  // OSC MESSAGES:
  
  // Path:    /mouse/down
  // Format:  T
  // Fields:  state
  
  // Path:    /mouse/moved
  // Format:  ii
  // Fields:  mouseX, mouseY


import netP5.*;
import oscP5.*;

OscP5 oscP5;

// input resolution
int w = 320, h = 240;

// Name or IP of the target machine
String remote_machine = "localhost";

// Port of the target machine
int remote_port = 12000;
int local_port = 13000;

NetAddress remote;


void setup() {
  
  // input screen
  size(320, 240);

  // create osc connection
  oscP5 = new OscP5(this, local_port);
  remote = new NetAddress(remote_machine, remote_port);
  
}

void draw() {
  background(255); 
}


void mouseMoved() {
  sendMessage("/mousemoved", mouseX, mouseY);
}


void mousePressed() {
  sendMessage("/mouse/down", true);
}

void mouseReleased() {
  sendMessage("/mouse/down", false);
}

void mouseDragged() {
  sendMessage("/mouse/down", true);
  sendMessage("/mouse/moved", mouseX, mouseY);
}


// generic function for sending OSC messages with ints
void sendMessage(String path, int... args) {
  
    // create an OSC message
    OscMessage msg = new OscMessage(path);
    
    // add all the arguments
    for(int i = 0; i < args.length; i++) {
          msg.add(args[i]);
    }
    
    // send it
    oscP5.send(msg, remote);
    
}

// generic function for sending OSC messages with booleans
void sendMessage(String path, boolean... args) {
  
    // create an OSC message
    OscMessage msg = new OscMessage(path);
    
    // add all the arguments
    for(int i = 0; i < args.length; i++) {
          msg.add(args[i]);
    }
    
    // send it
    oscP5.send(msg, remote);
    
}