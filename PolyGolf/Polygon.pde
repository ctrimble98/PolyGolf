class Polygon extends Shape {

    private List<PVector> points;

    public Polygon(List<PVector> points, PVector centre, float boundingRadius) {
        super(ShapeType.POLYGON, centre, boundingRadius);
        this.points = points;
    }

    public List<PVector> getPoints() {
        return points;
    }

    public void setImage(PGraphics pg) {
        pg.beginShape();
        for (PVector p: points) {
            pg.vertex(p.x, p.y);
        }
        pg.endShape(CLOSE);
    }
}
