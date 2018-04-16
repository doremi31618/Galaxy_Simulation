// A 3d vector
class Vector {
  float x;
  float y;
  float z;
  
  Vector() {
    x = 0;
    y = 0;
    z = 0;
  }
  
  // Add a vector to this one
  void add(Vector v) {
    x += v.x;
    y += v.y;
    z += v.z;
  }
  
  // Return the value as if the vector were added to this one,
  // but does not change this vector at all
  Vector addedTo(Vector v) {
    Vector result = new Vector();
    result.x = x + v.x;
    result.y = y + v.y;
    result.z = z + v.z;
    return result;
  }
  
  // Returns this vector as if it were multiplied by the value,
  // but does not change this vector at all
  Vector multipliedBy(float value) {
    Vector result = new Vector();
    result.x = x * value;
    result.y = y * value;
    result.z = z * value;
    return result;
  }
  
  // Returns this vector as if it were normalized, but does not
  // change this vector at all
  Vector normalized() {
    Vector normalVector = new Vector();
    float distance = length();
    normalVector.x = x / distance;
    normalVector.y = y / distance;
    normalVector.z = z / distance;
    return normalVector;
  }
  
  // Returns the length of this vector
  float length() {
    return (sqrt(x * x + y * y + z * z));
  }
}