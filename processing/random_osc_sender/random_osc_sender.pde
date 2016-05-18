
  /////////////////////////////////////////////////////////////////
  //                                                             //
  //     R A N D O M     O S C     S E N D E R                   //
  //                                                             //
  /////////////////////////////////////////////////////////////////
  
  // Path:    /face/id
  // Format:  ffff
  // Fields:  x1, y1, x2, y2 (coords of upper left corner, and lower light corner)
  
import netP5.*;
import oscP5.*;

OscP5 oscP5;

// Name or IP of the target machine
String remote_machine = "enigma.medien.uni-weimar.de";

// Port of the target machine
int remote_port = 13000;
int local_port = 12000;

NetAddress remote;

// random number
int rand;

void setup() {
  // create osc connection
  oscP5 = new OscP5(this, local_port);
  remote = new NetAddress(remote_machine, remote_port);
}

void draw() {
  background(rand, rand, rand);
}

void keyPressed() {
    OscMessage msg = new OscMessage("/random");
    rand = int(random(256));
    msg.add(rand);
    oscP5.send(msg, remote);
}