static class PhysicsEngine {

    public static boolean checkCollision(Shape s1, Shape s2) {

        if (checkCollisionCircCirc(s1.getPosition(), s1.getBoundingRadius(), s2.getPosition(), s2.getBoundingRadius())) {
            if (s1.getType() == ShapeType.POLYGON && s2.getType() == ShapeType.POLYGON) {
                return checkCollisionPolyPoly(((Polygon)s1).getPoints(), ((Polygon)s2).getPoints());
            } else if (s1.getType() == ShapeType.POLYGON && s2.getType() == ShapeType.POLYGON) {
                return checkCollisionCircPoly(((Circle)s1).getPosition(), ((Circle)s1).getRadius(), ((Polygon)s2).getPoints());
            } else if (s1.getType() == ShapeType.POLYGON && s2.getType() == ShapeType.POLYGON) {
                return checkCollisionCircPoly(((Circle)s2).getPosition(), ((Circle)s2).getRadius(), ((Polygon)s1).getPoints());
            } else {
                return true;
            }
        }
        return false;
    }

    public static boolean checkCollisionCircCirc(PVector p1, float r1, PVector p2, float r2) {
        float distBetween = p1.dist(p2);
        float minDist = r1 + r2;
        if (distBetween < minDist) {
            return true;
        }
        return false;
    }

    //From http://www.jeffreythompson.org/collision-detection/poly-circle.php
    public static boolean checkCollisionCircPoly(PVector position, float radius, List<PVector> vertices) {

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
            boolean collision = checkCollisionCircLine(position, radius, vertices.get(i).x,vertices.get(i).y,  vertices.get(next).x, vertices.get(next).y);
            if (collision) {
                return true;
            }
        }
        return false;
    }

    // Formula from http://mathworld.wolfram.com/Circle-LineIntersection.html
    public static boolean checkCollisionCircLine(PVector position, float radius, float v1x, float v1y, float v2x, float v2y) {

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
    public static boolean checkCollisionPolyPoly(List<PVector> p1, List<PVector> p2) {

        // go through each of the vertices, plus the next
        // vertex in the list
        int next = 0;
        for (int current=0; current<p1.size(); current++) {

            // get next vertex in list
            // if we've hit the end, wrap around to 0
            next = current+1;
            if (next == p1.size()) {
                next = 0;
            }

            // get the PVectors at our current position
            // this makes our if statement a little cleaner
            PVector vc = p1.get(current);    // c for "current"
            PVector vn = p1.get(next);       // n for "next"

            // now we can use these two points (a line) to compare
            // to the other polygon's vertices using polyLine()
            boolean collision = checkCollisionPolyLine(p2, vc.x,vc.y,vn.x,vn.y);
            if (collision) return true;

            // // optional: check if the 2nd polygon is INSIDE the first
            // collision = polyPoint(p1, p2.get(0).x, p2.get(0).y);
            // if (collision) return true;
        }

        return false;
    }


    // POLYGON/LINE
    public static boolean checkCollisionPolyLine(List<PVector> vertices, float x1, float y1, float x2, float y2) {

        // go through each of the vertices, plus the next
        // vertex in the list
        int next = 0;
        for (int current=0; current<vertices.size(); current++) {

        // get next vertex in list
        // if we've hit the end, wrap around to 0
        next = current+1;
        if (next == vertices.size()) next = 0;

            // get the PVectors at our current position
            // extract X/Y coordinates from each
            float x3 = vertices.get(current).x;
            float y3 = vertices.get(current).y;
            float x4 = vertices.get(next).x;
            float y4 = vertices.get(next).y;

            // do a Line/Line comparison
            // if true, return 'true' immediately and
            // stop testing (faster)
            boolean hit = checkCollisionLineLine(x1, y1, x2, y2, x3, y3, x4, y4);
            if (hit) {
                return true;
            }
        }

        // never got a hit
        return false;
    }


    // LINE/LINE
    public static boolean checkCollisionLineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

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
