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
int PROCESS_COUNT = 10;

void setup() {
  size(640, 480, P3D);
  
  planet = new CoreSphere(total,corePoint,40,0.05);
  cam = new PeasyCam(this,300);
  
  stars = new Star[STAR_COUNT];
  for (int i = 0; i < STAR_COUNT; i++) {
    stars[i] = new Star();
    float direction = random(2 * PI);
    float distance = 1 + abs(random(500) + random(-500));
    if (distance > 400) {
      distance = 1 + abs(random(40) + random(-40));
    }
    stars[i].position.x = cos(direction) * distance;
    stars[i].position.z = sin(direction) * distance;
    if (distance > 10) {
      stars[i].position.y = (-150 + random(300)) / pow(distance, .7);
    } else {
      stars[i].position.y = (-150 + random(300)) / 10;
    }
    stars[i].velocity.x = cos(direction + HALF_PI) * GALAXY_SPEED;
    stars[i].velocity.z = sin(direction + HALF_PI) * GALAXY_SPEED;
    stars[i].velocity.y = (-1 + random(2)) * GALAXY_SPEED / pow(distance, .7);
    float rand = random(40);
    if (stars[i].position.x < 0) {
      stars[i].colour = color(#FFB4F8);
    } else {
      stars[i].colour = color(#D9B4FF);
    }
  }
}
void draw() {
  
  
  if (mousePressed) {
    pitch -= (mouseY - pmouseY) * .01;
    yaw += (mouseX - pmouseX) * .01;
  }
  
  for (int count = 0; count < PROCESS_COUNT; count++) {
    for (int i = 0; i < STAR_COUNT; i++) {
      float distance = stars[i].position.length();
      Vector acceleration = stars[i].position.normalized().multipliedBy(-GALAXY_SPEED * GALAXY_SPEED / distance / PROCESS_COUNT);
      stars[i].position.add(stars[i].velocity.addedTo(acceleration.multipliedBy(.5)).multipliedBy(1.0 / PROCESS_COUNT));
      stars[i].velocity.add(acceleration);
    }
  }
  
  background(0);
  pushMatrix();
    scale(zoom);
    rotateX(pitch);
    rotateY(yaw);
    sphereDetail(3);
    for (int i = 0; i < STAR_COUNT; i++) {
      stroke(stars[i].colour);
      fill(stars[i].colour);
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
