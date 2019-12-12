class Polygon extends Shape {

    private List<PVector> points;

    public Polygon(List<PVector> points, PVector centre, float boundingRadius) {
        super(ShapeType.POLYGON, centre, boundingRadius);
        this.points = points;
    }

    public List<PVector> getPoints(PVector relativePos) {
        if (relativePos != null) {
            List<PVector> relativePoints = new ArrayList<PVector>();
            for (PVector p: points) {
                relativePoints.add(p.copy().add(relativePos));
            }
            return relativePoints;
        }
        return points;
    }

    public void setImage(PGraphics pg) {
        pg.beginShape();
        for (PVector p: points) {
            pg.vertex(p.x + position.x, p.y + position.y);
        }
        pg.endShape(CLOSE);
    }
}
