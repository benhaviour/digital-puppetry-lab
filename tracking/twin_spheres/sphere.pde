

class Sphere {
  
  // position of the sphere
  float x, y, z;
  color c;
  
  Sphere( color c) {
    this.c = c;
  }
  
  // draw the sphere
  void draw() {
    pushMatrix();
    stroke(0, 127);
    fill(c);
    translate(x, y, z);
    sphere(50);
    popMatrix();
  }
    
  // update the position of the root node 
  // (this function will be plugged to OSC)
  public void updateRoot(float x, float y, float z) {
    this.x = map(x, 0, 100, -width/2, width/2);
    this.y = map(y, -100, 100, -height/2, height/2);
    this.z = map(z, 0, 100, 0, depth);
  }
      
}