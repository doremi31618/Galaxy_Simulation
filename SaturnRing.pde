public class SaturnRing{
  ArrayList<Particle> saturnRing = new ArrayList<Particle>();
  int total;
  float speed = 0f;
  float r = 300;
  float angle1 ;
  float angle2;
  //PVector corePosition,float angle1,float angle2,float _r
  public SaturnRing(int _total,PVector _corePosition,float xAngle,float yAngle,float _r,float rotateSpeed){
    total = _total;
    r = _r;
    speed = rotateSpeed;
    angle1 = xAngle;
    angle2 = yAngle;
    MakingSaturnRing(_corePosition);
  }
  
  private void MakingSaturnRing(PVector corePosition){
    print(angle1 + " , " + angle2);
    for(int i=0; i<total*1.5; i++){
      float lat = map(i,0,total,-PI,PI);
      for(int j=0; j<total*1.5; j++){
        float lon = map(j,0,total,-PI,PI);
      
        float x = corePosition.x + r * sin(lon) * cos(lat);
        float y = corePosition.y ;
        float z = corePosition.z + r * cos(lon);
      
        PVector point = new PVector(x,y,z);
        if(PVector.dist(point,corePosition) > r*0.9){
          saturnRing.add(new Particle(point,color(#6094FA,100)));
        }
      }
    }
    
  }
  float t;
  public void display(){
    pushMatrix();
    strokeWeight(2);
    t +=speed;
    rotateX(angle1 + t);
    rotateZ(angle2 + t);
    for(Particle p : saturnRing){
     p.display();
    }
    popMatrix();
 }

}