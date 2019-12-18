class Polygon extends Shape {

    private List<PVector> vertices;

    public Polygon(List<PVector> vertices, PVector centre, float boundingRadius) {
        super(ShapeType.POLYGON, centre, boundingRadius);
        this.vertices = vertices;
    }

    public List<PVector> getVertices(PVector relativePos) {
        if (relativePos != null) {
            List<PVector> relativeVertices = new ArrayList<PVector>();
            for (PVector v: vertices) {
                relativeVertices.add(v.copy().add(relativePos));
            }
            return relativeVertices;
        }
        return vertices;
    }

    public void setImage(PGraphics pg) {
        pg.beginShape();
        for (PVector v: vertices) {
            pg.vertex(v.x + position.x, v.y + position.y);
        }
        pg.endShape(CLOSE);
    }
}
