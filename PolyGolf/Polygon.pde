class Polygon extends Shape {

    private List<PVector> vertices;

    public Polygon(List<PVector> vertices, PVector centre, float boundingRadius) {
        super(ShapeType.POLYGON, centre, boundingRadius);
        this.vertices = vertices;
        if (vertices.size = 4) {
            inertia = (1/12)*(sq(vertices.get(0).dist(vertices.get(1))) + sq(vertices.get(0).dist(vertices.get(1))));
        } else {
            inertia = 0.5 * sq(boundingRadius);
        }
    }

    public List<PVector> getVertices(PVector relativePos) {
        if (relativePos == null) {
            relativePos = new PVector(0, 0);
        }
        List<PVector> relativeVertices = new ArrayList<PVector>();
        for (PVector v: vertices) {
            relativeVertices.add(v.copy().rotate(orientation).add(relativePos));
        }
        return relativeVertices;
    }

    public void setImage(PGraphics pg) {
        pg.beginShape();
        for (PVector v: vertices) {
            pg.vertex(v.x + position.x, v.y + position.y);
        }
        pg.endShape(CLOSE);
    }
}
