static class PhysicsEngine {

    //From http://www.jeffreythompson.org/collision-detection/poly-circle.php
    public static boolean checkCollsionCircPoly(PVector position, int radius, List<PVector> vertices) {

        // go through each of the vertices, plus
        // the next vertex in the list
        int next = 0;
        int n = vertices.size();
        for (int i = 0; i < n; i++) {

            // get next vertex in list
            // if we've hit the end, wrap around to 0
            next = (i + 1) % n;

            // check for collision between the circle and
            // a line formed between the two vertices
            boolean collision = checkCollisionPartLine(position, radius, vertices.get(i).x,vertices.get(i).y,  vertices.get(next).x, vertices.get(next).y);
            if (collision) {
                return true;
            }
        }
        return false;
    }

    // Formula from http://mathworld.wolfram.com/Circle-LineIntersection.html
    public static boolean checkCollisionPartLine(PVector position, int radius, float v1x, float v1y, float v2x, float v2y) {

        if ((((v1x < position.x && v2x < position.x) || (v1x > position.x && v2x > position.x)) && ((v1y < position.y && v2y < position.y) || (v1y > position.y && v2y > position.y)))) {
            return false;
        }

        v1x -= position.x;
        v1y -= position.y;
        v2x -= position.x;
        v2y -= position.y;

        if (abs(v1x) > radius && abs(v1y) > radius && abs(v2x) > radius && abs(v2y) > radius) {
            return false;
        }

        float dx = v2x - v1x;
        float dy = v2y - v1y;
        float dr2 = dx*dx + dy*dy;
        float D = v1x*v2y - v2x*v1y;

        return radius*radius * dr2 - D*D >= 0;
    }

    // POLYGON/POLYGON
boolean polyPoly(PVector[] p1, PVector[] p2) {

  // go through each of the vertices, plus the next
  // vertex in the list
  int next = 0;
  for (int current=0; current<p1.length; current++) {

    // get next vertex in list
    // if we've hit the end, wrap around to 0
    next = current+1;
    if (next == p1.length) next = 0;

    // get the PVectors at our current position
    // this makes our if statement a little cleaner
    PVector vc = p1[current];    // c for "current"
    PVector vn = p1[next];       // n for "next"

    // now we can use these two points (a line) to compare
    // to the other polygon's vertices using polyLine()
    boolean collision = polyLine(p2, vc.x,vc.y,vn.x,vn.y);
    if (collision) return true;

    // optional: check if the 2nd polygon is INSIDE the first
    collision = polyPoint(p1, p2[0].x, p2[0].y);
    if (collision) return true;
  }

  return false;
}


// POLYGON/LINE
boolean polyLine(PVector[] vertices, float x1, float y1, float x2, float y2) {

  // go through each of the vertices, plus the next
  // vertex in the list
  int next = 0;
  for (int current=0; current<vertices.length; current++) {

    // get next vertex in list
    // if we've hit the end, wrap around to 0
    next = current+1;
    if (next == vertices.length) next = 0;

    // get the PVectors at our current position
    // extract X/Y coordinates from each
    float x3 = vertices[current].x;
    float y3 = vertices[current].y;
    float x4 = vertices[next].x;
    float y4 = vertices[next].y;

    // do a Line/Line comparison
    // if true, return 'true' immediately and
    // stop testing (faster)
    boolean hit = lineLine(x1, y1, x2, y2, x3, y3, x4, y4);
    if (hit) {
      return true;
    }
  }

  // never got a hit
  return false;
}


// LINE/LINE
boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

  // calculate the direction of the lines
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  // if uA and uB are between 0-1, lines are colliding
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
    return true;
  }
  return false;
}
}
