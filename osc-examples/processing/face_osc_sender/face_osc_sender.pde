
  /////////////////////////////////////////////////////////////////
  //                                                             //
  //     F A C E     O S C     S E N D E R                       //
  //                                                             //
  /////////////////////////////////////////////////////////////////
  
  // OSC-Sender using Camera Input + Face Detection
  
  // OSC MESSAGE:
  
  // Path:    /face
  // Format:  ffff
  // Fields:  id, x1, y1, x2, y2 (id, coords of upper left corner, and lower light corner)


import netP5.*;
import oscP5.*;
import processing.video.Capture;
import gab.opencv.OpenCV;
import java.awt.Rectangle;

Capture cam;
OpenCV opencv;
OscP5 oscP5;

// input resolution
int w = 320, h = 240;

// output zoom
int zoom = 3;

// Name or IP of the target machine
String remote_machine = "localhost";

// Port of the target machine
int remote_port = 12000;
int local_port = 13000;

NetAddress remote;


void setup() {

  // actual size, is a result of input resolution and zoom factor
  size(960, 720);

  // capture camera with input resolution
  cam = new Capture(this, w, h);
  cam.start();

  // init OpenCV with input resolution
  opencv = new OpenCV(this, w, h);

  // setup for facial recognition
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  // create
  oscP5 = new OscP5(this, local_port);
  remote = new NetAddress(remote_machine, remote_port);

  // limit frameRate
  //frameRate(30);
}


void draw() {

  // get the camera image
  opencv.loadImage(cam);

  // detect faces
  Rectangle[] faces = opencv.detect();

  // zoom to input resolution
  scale(zoom);

  // draw input image
  image(opencv.getInput(), 0, 0);

  // draw rectangles around detected faces
  fill(255, 64);
  strokeWeight(3);
  
  for (int i = 0; i < faces.length; i++) {
    
    Rectangle face = faces[i];

    // draw rectangle on screen
    rect(face.x, face.y, face.width, face.height);
    
    // send OSC message containing rectangle coordinates
    OscMessage msg = new OscMessage("/face");
    msg.add(i);
    msg.add(face.x);
    msg.add(face.y);
    msg.add(face.width);
    msg.add(face.height);
    oscP5.send(msg, remote);
    
  }

  // show performance and number of detected faces on the console
  if (frameCount % 50 == 0) {
    println("Frame rate:", round(frameRate), "fps");
    println("Number of faces:", faces.length);
  }
}

// read a new frame when it's available
void captureEvent(Capture c) {
  c.read();
}