class CelestialBody {
  
  float radius;
  float angle;
  float distance;
  float defaultOrbitSpeed;
  CelestialBody moon;
  PVector vector;
  PShape globe;
  String name;
  
  CelestialBody(float radius, float distance, float defaultOrbitSpeed) {
    this.vector = PVector.random3D();
    this.radius = radius;
    this.angle = random(TWO_PI);
    this.distance = distance;
    vector.mult(distance);
    this.defaultOrbitSpeed = defaultOrbitSpeed;
    noStroke();
    this.globe = createShape(SPHERE, radius);
  }
  
  void orbit(float speedIncrease, int level) {
    angle += defaultOrbitSpeed + speedIncrease;
    if(level > 0) moon.orbit(speedIncrease, level - 1);
  }
  
  void show(int level) {
    pushMatrix();
    
    PVector perpendicular = vector.cross(new PVector(1, 0, 1));
    rotate(angle, perpendicular.x, perpendicular.y, perpendicular.z);
    translate(vector.x, vector.y, vector.z);
    shape(globe);
    translate(-this.radius / 2, -(this.radius + 10), 0);
    fill(255);
    if(level > 0) moon.show(level - 1);
    
    popMatrix();
  }
  
    void spawnMoon() {
    this.moon = new CelestialBody(20, 130, 0.05);
  }
}
