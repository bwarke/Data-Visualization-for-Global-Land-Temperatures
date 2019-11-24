class Oscillation { //rotating the arcs for temperatures back and forth - from slow to fast to slow - based on a random sin wave
  // radians values
  float oscillationRange;
  float initialPhaseOffset;
  float omega = radians(5);
  Oscillation(float initialPhaseOffset, float oscillationRange) {
    this.initialPhaseOffset = initialPhaseOffset;
    this.oscillationRange = oscillationRange;
  }
  
  // called once per frame
  float oscillate() {
    float currentAngle = (float) (oscillationRange / 2 * Math.sin(omega * (millis() / 60) + initialPhaseOffset));
    return currentAngle;
  }
}
