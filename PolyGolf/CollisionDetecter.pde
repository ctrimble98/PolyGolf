class CollisionDetector {

    private Particle p1;
    private Particle p2;

    public void addContact(PVector position, PVector normal, float penetration) {
        contacts.add(new Contact(p1, p2, position, normal, penetration));
    }

    public void checkCollision(Particle p1, Particle p2) {

        this.p1 = p1;
        this.p2 = p2;

        Shape s1 = p1.getShape();
        Shape s2 = p2.getShape();

        // Contact collision = checkCollisionCircCirc(s1.getPosition(), s1.getBoundingRadius(), s2.getPosition(), s2.getBoundingRadius());

        if (checkCollisionCircCirc(s1.getPosition(), s1.getBoundingRadius(), s2.getPosition(), s2.getBoundingRadius(), true)) {
            if (s1.getType() == ShapeType.POLYGON && s2.getType() == ShapeType.POLYGON) {
                PVector relPos = s2.getPosition().copy().sub(s1.getPosition());
                checkCollisionPolyPoly((Polygon)s1, (Polygon)s2);
            } else if (s1.getType() == ShapeType.CIRCLE && s2.getType() == ShapeType.POLYGON) {
                PVector relPos = s2.getPosition().copy().sub(s1.getPosition());
                checkCollisionCircPoly(s1.getPosition(), s1.getBoundingRadius(), ((Polygon)s2).getVertices(relPos));
            } else if (s1.getType() == ShapeType.POLYGON && s2.getType() == ShapeType.CIRCLE) {
                PVector relPos = s1.getPosition().copy().sub(s2.getPosition());
                checkCollisionCircPoly(s2.getPosition(), s2.getBoundingRadius(), ((Polygon)s1).getVertices(relPos));
            } else {
                //Both shapes were circles
                checkCollisionCircCirc(s1.getPosition(), s1.getBoundingRadius(), s2.getPosition(), s2.getBoundingRadius(), false);
            }
        }
    }

    public boolean checkCollisionCircCirc(PVector p1, float r1, PVector p2, float r2, boolean bounding) {
        float distBetween = p1.dist(p2);
        float minDist = r1 + r2;
        if (distBetween < minDist) {
            if (bounding) {
                addContact(new PVector((p1.x*r2+p2.x*r1)/(r1+r2), (p1.y*r2+p2.y*r1)/(r1+r2)), p2.copy().sub(p1).normalize(), minDist - distBetween);
            }
            return true;
        }
        return false;
    }

    //From http://www.jeffreythompson.org/collision-detection/poly-circle.php
    public Contact checkCollisionCircPoly(PVector position, float radius, List<PVector> vertices) {

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
            Contact collision = checkCollisionCircLine(position, radius, vertices.get(i).x,vertices.get(i).y,  vertices.get(next).x, vertices.get(next).y);
            if (collision != null) {
                return collision;
            }
        }
        return null;
    }

    // Formula from http://mathworld.wolfram.com/Circle-LineIntersection.html
    public Contact checkCollisionCircLine(PVector position, float radius, float v1x, float v1y, float v2x, float v2y) {

        if ((((v1x < position.x && v2x < position.x) || (v1x > position.x && v2x > position.x)) && ((v1y < position.y && v2y < position.y) || (v1y > position.y && v2y > position.y)))) {
            return null;
        }

        v1x -= position.x;
        v1y -= position.y;
        v2x -= position.x;
        v2y -= position.y;

        if (abs(v1x) > radius && abs(v1y) > radius && abs(v2x) > radius && abs(v2y) > radius) {
            return null;
        }

        float dx = v2x - v1x;
        float dy = v2y - v1y;
        float dr2 = dx*dx + dy*dy;
        float D = v1x*v2y - v2x*v1y;

        float discriminant = radius*radius * dr2 - D*D;

        // if (!needCollisionPoint) {
        //     if (discriminant >= 0) {
        //         return new PVector(0,0);
        //     }
        //     return null;
        // }

        if (discriminant > 0) {
            float dRoot = sqrt(D);
            float xRoot = sign(dy)*dx*dRoot;
            float yRoot = abs(dy)*dRoot;

            PVector p1 = new PVector((D*dy + xRoot)/dr2, (-D*dx + yRoot)/dr2);
            PVector p2 = new PVector((D*dy - xRoot)/dr2, (-D*dx - yRoot)/dr2);
            PVector collisionPosition = position.copy().add(p1.sub(position).add(p2.sub(position)).normalize().add(radius, radius));

            PVector normal = position.copy().sub(collisionPosition.copy()).normalize();

            //https://stackoverflow.com/questions/26951544/algorithm-find-the-midpoint-of-an-arc
            // return new Contact(collisionPosition, normal);

        } else if (discriminant == 0) {
            PVector collisionPosition = new PVector(D*dy/dr2, -D*dx/dr2);
            PVector normal = position.copy().sub(collisionPosition.copy()).normalize();
            // return new Contact(collisionPosition, normal);
        }
        return null;
    }

    // // POLYGON/POLYGON
    // public void checkCollisionPolyPoly(List<PVector> p1, List<PVector> p2) {
    //
    //     // go through each of the vertices, plus the next
    //     // vertex in the list
    //     int next = 0;
    //     for (int current=0; current<p1.size(); current++) {
    //
    //         // get next vertex in list
    //         // if we've hit the end, wrap around to 0
    //         next = current+1;
    //         if (next == p1.size()) {
    //             next = 0;
    //         }
    //
    //         // get the PVectors at our current position
    //         // this makes our if statement a little cleaner
    //         PVector vc = p1.get(current);    // c for "current"
    //         PVector vn = p1.get(next);       // n for "next"
    //
    //         // now we can use these two points (a line) to compare
    //         // to the other polygon's vertices using polyLine()
    //         Contact collision = checkCollisionPolyLine(p2, vc.x,vc.y,vn.x,vn.y);
    //         if (collision != null) return collision;
    //
    //         // // optional: check if the 2nd polygon is INSIDE the first
    //         // collision = polyPoint(p1, p2.get(0).x, p2.get(0).y);
    //         // if (collision) return true;
    //     }
    //
    //     return null;
    // }

    // POLYGON/POLYGON
    public void checkCollisionPolyPoly(Polygon poly1, Polygon poly2) {

        PVector relPos = poly2.getPosition().copy().sub(poly1.getPosition());

        List<PVector> v1 = poly1.getVertices(null);
        List<PVector> v2 = poly2.getVertices(relPos);

        //Get the contacts between the vertices of p1 and the edges of p2 relative to p1
        for (PVector p: v1) {
            Contact c = checkContactPolyPoint(poly2, p.x, p.y, relPos);
            if (c != null) {
                contacts.add(c);
            }
        }

        //Get the contacts between the vertices of p2 and the edges of p1 relative to p1
        for (PVector p: v2) {
            Contact c = checkContactPolyPoint(poly1, p.x, p.y, relPos);
            if (c != null) {
                contacts.add(c);
            }
        }


        // Contact c = checkContactPolyPoint(poly2, v1.get(0).x, v1.get(0).y, relPos);
        // if (c != null) {
        //     contacts.add(c);
        // }
        //
        // System.out.println(v1.get(0));
        // System.out.println(v2.get(0));
        // System.out.println();
        //
        // c = checkContactPolyPoint(poly1, v2.get(0).x, v2.get(0).y, relPos);
        // if (c != null) {
        //     contacts.add(c);
        // }
    }


    // POLYGON/LINE
    public Contact checkCollisionPolyLine(Polygon p, float x1, float y1, float x2, float y2) {

        // go through each of the vertices, plus the next
        // vertex in the list
        List<PVector> vertices = p.getVertices(null);
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
            PVector collisionPosition = checkCollisionLineLine(x1, y1, x2, y2, x3, y3, x4, y4);
            if (collisionPosition != null) {
                // return new Contact(collisionPosition, );
            }
        }

        // never got a hit
        return null;
    }


    // LINE/LINE
    public PVector checkCollisionLineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

        // calculate the direction of the lines
        float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
        float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

        // if uA and uB are between 0-1, lines are colliding
        if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
            float intersectionX = x1 + (uA * (x2-x1));
            float intersectionY = y1 + (uA * (y2-y1));
            return new PVector(intersectionX, intersectionY);
        }
        return null;
    }

    public Contact checkContactPolyPoint(Polygon p, float x, float y, PVector relPos) {

        List<PVector> vertices = p.getVertices(relPos);
        int next = 0;
        float minPenDepth = displayWidth;
        Contact c = null;

        if (!checkCollisionPolyPoint(vertices, x, y)) {
            return null;
        }

        for (int current = 0; current<vertices.size(); current++) {

            // get next vertex in list
            // if we've hit the end, wrap around to 0
            next = current + 1;
            if (next == vertices.size()) next = 0;

            // get the PVectors at our current position
            // extract X/Y coordinates from each
            float x1 = vertices.get(current).x;
            float y1 = vertices.get(current).y;
            float x2 = vertices.get(next).x;
            float y2 = vertices.get(next).y;

            float xDiff = x2 - x1;
            float yDiff = y2 - y1;

            //Check if center of polygon is on same side of line as the  point to know if point is inside polygon
            // https://math.stackexchange.com/questions/162728/how-to-determine-if-2-points-are-on-opposite-sides-of-a-line
            if ((-yDiff*(x - x1) + xDiff*(y - y1))*(-yDiff*(p.getPosition().x - x1) + xDiff*(p.getPosition().y - y1)) >= 0) {

                float lineLen = sqrt(sq(yDiff) + sq(xDiff));
                float penDepth = abs(yDiff*x - xDiff*y + x2*y1 - y2*x1)/lineLen;

                if (penDepth < minPenDepth) {
                    minPenDepth = penDepth;
                    c = new Contact(p1, p2, new PVector(x, y), new PVector(-yDiff,xDiff), penDepth);
                }

                stroke(255, 0, 0);
                strokeWeight(2);
                line(x1 + relPos.x,  y1 + relPos.y, x2 + relPos.x, y2 + relPos.y);
            }
        }
        return c;
    }

    //POLYGON/POINT
    public boolean checkCollisionPolyPoint(List<PVector> vertices, float x, float y) {

        boolean collision = false;
        for (int current = 0; current<vertices.size(); current++) {

            // get next vertex in list
            // if we've hit the end, wrap around to 0
            int next = current + 1;
            if (next == vertices.size()) next = 0;

            PVector vc = vertices.get(current);
            PVector vn = vertices.get(next);
            if (((vc.y >= y && vn.y < y) || (vc.y < y && vn.y >= y)) &&  (x < (vn.x-vc.x)*(y-vc.y) / (vn.y-vc.y)+vc.x)) {
                collision = !collision;
            }
        }

        return collision;
    }

    public int sign(float x) {
        if (x >= 0) {
            return 1;
        }
        return -1;
    }
}
