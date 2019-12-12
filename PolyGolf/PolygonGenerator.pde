class PolygonGenerator {

    //Structure of function taken from processing docs
    public Shape getRegularPolygon(int sides, int radius, float offsetAngle, PVector centre) {
        ArrayList<PVector> points = new ArrayList<PVector>();
        float angle = 2*PI / sides;
        for (float a = offsetAngle; a < offsetAngle + 2*PI; a += angle) {
            float x = /*centre.x + */cos(a) * radius;
            float y = /*centre.y + */sin(a) * radius;
            points.add(new PVector(x, y));
        }
        return new Polygon(points, centre, radius);
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
