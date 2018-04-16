public class CoreSphere{
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int total;//number of particles ,control the density
  PVector corePosition;
  float radius;
  float speed;
  
  public CoreSphere(int _total,PVector _corePosition,float _radius,float rotateSpeed){
    total = _total;
    corePosition = _corePosition;
    radius = _radius;
    MakingSurface(corePosition);
    speed = rotateSpeed;
  }//end of setup class
  
  private void MakingSurface(PVector corePosition){
  
    if(radius == 0 ){
      radius = 200;
    }
    
    for(int i = 0; i < total*1.5; i++){
      float lon = map(i,0,total,-PI,PI);
      for(int j = 0; j < total*1.5;j++){
        float lat = map(j,0,total,-PI,PI);
      
        float x = corePosition.x + radius * sin(lon) * cos(lat);
        float y = corePosition.y + radius * sin(lon) * sin(lat);
        float z = corePosition.z + radius * cos(lon);
      
      
        int R = (int)map(i,0,total,247,157);
        int G = (int)map(i,0,total,137,136);
        int B = (int)map(i,0,total,96,247);
      
        particles.add(new Particle(new PVector(x,y,z),color(#B4F7FF,100)));
      
      
        if( 99 > random(0,100)){
          stroke(R,G,B,60);
          line(corePosition.x,corePosition.y,corePosition.z,x,y,z);
        }
   
      }
    }//end of iterate data structure
   }//end of function MakingSurface
   float angle = 0;
 public void display(){
   pushMatrix();
   angle+=speed;
   strokeWeight(2);
   rotateY(angle);
   for(Particle p : particles){
     p.display();
   }
   popMatrix();
 }
 
}