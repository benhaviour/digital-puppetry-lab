
  /////////////////////////////////////////////////////////////////
  //                                                             //
  //     R A N D O M     O S C     S E N D E R                   //
  //                                                             //
  /////////////////////////////////////////////////////////////////
  
  // Path:            /random
  // Format:          i
  // Interpretation:  Radom Number between 0 and 255
  
import netP5.*;
import oscP5.*;

OscP5 oscP5;

// Name or IP of the target machine
String remote_machine = "localhost";

// Port of the target machine
int remote_port = 13000;

// Port of the local machine
int local_port = 12000;

NetAddress remote;

// random number
int randomNumber;

void setup() {
  
  size(400, 140);
  
  // create osc connection
  oscP5 = new OscP5(this, local_port);
  
  // create an object to represent the remote endpoint
  remote = new NetAddress(remote_machine, remote_port);
}

void draw() {
  
  background(0);
  
  // white text
  textAlign(CENTER);
  fill(255);
  text("RANDOM SENDER", 100, 30);
  text(">>> press any key <<<", 250, 30);
  
  // use the random number to color the rectangle
  stroke(255);
  fill(randomNumber);
  rect(20, 50, 360, 60);
 
}

void keyPressed() {
    
    // generate new random number and assign it to the global variable
    randomNumber = int(random(256));
    
    // generate an OSC message using "/random" as OSC-path
    OscMessage msg = new OscMessage("/random");
    
    // add the "payload" (i.e. the integer number)
    msg.add(randomNumber);
    
    // submit the OSC message
    oscP5.send(msg, remote);
    
}