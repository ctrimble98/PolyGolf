static class PolygonGenerator {

    //Structure of function taken from processing docs
    static ArrayList<PVector> getRegularPolygon(int sides, int radius, float offsetAngle, PVector centre) {
        ArrayList<PVector> points = new ArrayList<PVector>();
        float angle = 2*PI / sides;
        for (float a = offsetAngle; a < offsetAngle + 2*PI; a += angle) {
            float x = centre.x + cos(a) * radius;
            float y = centre.y + sin(a) * radius;
            points.add(new PVector(x, y));
        }
        return points;
    }

    static List<PVector> getRectangle(PVector topLeft, PVector bottomRight) {

        PVector bottomLeft = new PVector(topLeft.x, bottomRight.y);
        PVector topRight = new PVector(bottomRight.x, topLeft.y);
        return Arrays.asList(topLeft.copy(), bottomLeft, bottomRight.copy(), topRight);
    }
}
