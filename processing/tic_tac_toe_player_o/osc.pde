  
  // SENDING OSC
  
  // Path:            /matrix/x
  // Format:          ii
  // Interpretation:  xpos, ypos (position of the X-tile)
  
  // Path:           /matrix/clear
  // Interpretation: reset the board
  
  
  // RECEIVING OSC
  
  // Path:            /matrix/o
  // Format:          ii
  // Interpretation:  xpos, ypos (position of the O-tile)
  
  // Path:           /matrix/clear
  // Interpretation: reset the board

import netP5.*;
import oscP5.*;

OscP5 osc;

// Remote endpoint
NetAddress remote;

// Name or IP of the target machine
String remote_machine = "localhost";

// Port of the target machine
int remote_port = 12000;

// Port of the local machine
int local_port = 13000;


void setupOSC() {
   
  // create osc connection
  osc = new OscP5(this, local_port);
  
  // create an object to represent the remote endpoint
  remote = new NetAddress(remote_machine, remote_port);
  
  // setup the receiver
  osc.plug(this, "clearLocalBoard",  "/matrix/clear");
  osc.plug(this, "setLocalX", "/matrix/x");
  
}


void setRemoteO(int x, int y) {
  
     // generate an OSC message
    OscMessage msg = new OscMessage("/matrix/o");
    
    // add the payload (i.e. the position of the stone)
    msg.add(x);
    msg.add(y);
    
    // submit the OSC message
    osc.send(msg, remote); 
}

void clearRemoteBoard() {
  
  OscMessage msg = new OscMessage("/matrix/clear");
  osc.send(msg, remote);
 
}