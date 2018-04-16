public class Particle{
  PVector position;
  color c;
  public Particle(PVector _position,color _c)
  {
    position = _position;
    c = _c;
    //display();
  }
  public void display()
  {
    stroke(c);
    point(position.x,position.y,position.z);
  }
}