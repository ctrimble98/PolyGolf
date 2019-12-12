class PolygonGenerator {

    private ArrayList<PVector> getRegularPolygonPoints(int sides, int radius, float offsetAngle) {
        ArrayList<PVector> points = new ArrayList<PVector>();
        float angle = 2*PI / sides;
        for (float a = offsetAngle; a < offsetAngle + 2*PI; a += angle) {
            float x = cos(a) * radius;
            float y = sin(a) * radius;
            points.add(new PVector(x, y));
        }
        return points;
    }

    //Structure of function taken from processing docs
    public Shape getRegularPolygon(int sides, int radius, float offsetAngle, PVector centre) {
        ArrayList<PVector> points = getRegularPolygonPoints(sides, radius, offsetAngle);
        return new Polygon(points, centre, radius);
    }

    public Shape getRegularStar(int p, int q, int radius, float offsetAngle, PVector centre) {
        ArrayList<PVector> points = getRegularPolygonPoints(p, radius, offsetAngle);

        ArrayList<PVector> orderedPoints = new ArrayList<PVector>();
        int pointsAdded = 0;
        for (int i = 0; i < q; i++) {
            int j = i;
            boolean starting = true;
            while (starting || j != i) {
                orderedPoints.add(points.get(j));
                pointsAdded++;
                j = (j + q) % p;
                starting = false;
            }
            orderedPoints.add(points.get(j));
            orderedPoints.add(new PVector(0, 0));

            if (pointsAdded == points.size()) {
                break;
            }
        }

        return new Polygon(orderedPoints, centre, radius);
    }

    public Shape getRectangle(PVector topLeft, PVector bottomRight) {

        PVector centre = topLeft.copy().add(bottomRight.copy().sub(topLeft).div(2));
        float boundingRadius = topLeft.dist(centre);

        PVector bottomLeft = new PVector(topLeft.x, bottomRight.y);
        PVector topRight = new PVector(bottomRight.x, topLeft.y);
        List<PVector> points = Arrays.asList(topLeft.copy().sub(centre), bottomLeft.sub(centre), bottomRight.copy().sub(centre), topRight.sub(centre));

        return new Polygon(points, centre, boundingRadius);
    }
}
