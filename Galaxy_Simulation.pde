import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;

private int total = 100;
public PVector corePoint = new PVector(0,0,0);

CoreSphere planet;
//int _total,PVector _corePosition,float xAngle,float yAngle,float _r,float rotateSpeed
SaturnRing[] rings = {
                      new SaturnRing(total,corePoint,0,   0,50,0.1f),
                      new SaturnRing(total,corePoint,0,  40,70,0.05f),
                      new SaturnRing(total,corePoint,0, -40,90,0.01f)
                      };


Star[] stars;
float pitch = -PI / 2;
float yaw = 0;
float zoom = 1;
float GALAXY_SPEED = 1;
int STAR_COUNT = 2000;
// Due to inaccuracies of calculations, a loop is done this
// many times to make it closer to accurate.  I could have
// found the real solution, but I was lazy.
int PROCESS_COUNT = 10;

void setup() {
  size(640, 480, P3D);
  
  planet = new CoreSphere(total,corePoint,40,0.05);
  cam = new PeasyCam(this,300);
  
  stars = new Star[STAR_COUNT];
  for (int i = 0; i < STAR_COUNT; i++) {
    stars[i] = new Star();
    // Pick a random direction to create the star
    float direction = random(2 * PI);
    // Pick a random distance from the center.  There's a higher chance
    // the star will be in the center of the galaxy.
    float distance = 1 + abs(random(500) + random(-500));
    if (distance > 400) {
      distance = 1 + abs(random(40) + random(-40));
    }
    stars[i].position.x = cos(direction) * distance;
    stars[i].position.z = sin(direction) * distance;
    // Set the height of the star in the galaxy.  Stars very close to
    // the center are generally higher/lower than those farther away.
    if (distance > 10) {
      stars[i].position.y = (-150 + random(300)) / pow(distance, .7);
    } else {
      stars[i].position.y = (-150 + random(300)) / 10;
    }
    // Set each star's velocity to be perpendicular to the center of the galaxy.
    stars[i].velocity.x = cos(direction + HALF_PI) * GALAXY_SPEED;
    stars[i].velocity.z = sin(direction + HALF_PI) * GALAXY_SPEED;
    stars[i].velocity.y = (-1 + random(2)) * GALAXY_SPEED / pow(distance, .7);
    // Set the color to be slightly yellow or blue.
    float rand = random(40);
    if (stars[i].position.x < 0) {
      stars[i].colour = color(#FFB4F8);
    } else {
      stars[i].colour = color(#D9B4FF);
    }
  }
}
/*
void keyPressed() {
  if (key == 'a') {
    // Zoom in
    zoom *= 1.01;
  } else if (key == 'z') {
    // Zoom out
    zoom /= 1.01;
  } else if (key == 'r') {
    // Rotate with the galaxy
    yaw += GALAXY_SPEED * zoom / 2 / PI / 100;
  }
}
*/
void draw() {
  
  
  // Move when the mouse button is held
  if (mousePressed) {
    pitch -= (mouseY - pmouseY) * .01;
    yaw += (mouseX - pmouseX) * .01;
  }
  
  for (int count = 0; count < PROCESS_COUNT; count++) {
    for (int i = 0; i < STAR_COUNT; i++) {
      float distance = stars[i].position.length();
      // Gravity vector
      Vector acceleration = stars[i].position.normalized().multipliedBy(-GALAXY_SPEED * GALAXY_SPEED / distance / PROCESS_COUNT);
      // Update the position and velocity
      stars[i].position.add(stars[i].velocity.addedTo(acceleration.multipliedBy(.5)).multipliedBy(1.0 / PROCESS_COUNT));
      stars[i].velocity.add(acceleration);
    }
  }
  
  // Clear the screen with black
  background(0);
  // Start a 3d matrix
  pushMatrix();
    // Move galaxy to center of view
    //translate(width / 2, height / 2, zoom);
    // Zoom in
    scale(zoom);
    // Rotate along the x and y axis
    rotateX(pitch);
    rotateY(yaw);
    // Stars are spheres made of 3x3=9 polygons
    sphereDetail(3);
    for (int i = 0; i < STAR_COUNT; i++) {
      // Set the color of the star
      stroke(stars[i].colour);
      fill(stars[i].colour);
      // Start a matrix to move the star to its position before drawing it
      pushMatrix();
        translate(stars[i].position.x, stars[i].position.y, stars[i].position.z);
        sphere(stars[i].radius);
      popMatrix();
    }
    planet.display();
  
  for(SaturnRing ring : rings){
    ring.display();
  }
  popMatrix();
}