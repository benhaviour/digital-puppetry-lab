
  /////////////////////////////////////////////////////////////////
  //                                                             //
  //     R A N D O M     O S C     R E C E I V E R               //
  //                                                             //
  /////////////////////////////////////////////////////////////////
  
  
  // Path:            /random
  // Format:          i
  // Interpretation:  Radom Number between 0 and 255
  
import netP5.*;
import oscP5.*;

OscP5 oscP5;
// Port of the target machine
int remote_port = 12000;

// Port of the local machine
int local_port = 13000;

// Endpoint on the remote machine
NetAddress remote;

// global variable to store the random number
int randomNumber = 0;

void setup() {  
  
  size(400, 140);
  
  oscP5 = new OscP5(this, local_port);
  oscP5.plug(this, "randomEvent","/random");
}

void draw() {

  background(0);
  
  // white text
  textAlign(CENTER);
  fill(255);
  text("RANDOM RECEIVER", 100, 30);
  
  // use the random number to color the rectangle
  stroke(255);
  fill(randomNumber);
  rect(20, 50, 360, 60);
}

public void randomEvent(int n) {
  // assign the current integer to our global variable
  randomNumber = n;
}