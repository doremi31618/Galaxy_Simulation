class Star {
  color colour;
  Vector position;
  Vector velocity;
  float radius;
  
  Star() {
    position = new Vector();
    velocity = new Vector();
    colour = color(255, 255, 255);
    radius = 1.0;
  }
}