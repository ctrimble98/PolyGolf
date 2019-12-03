class Polygon {
    private PGraphics pg;
    protected List<PVector> points;
    protected PVector position;

    public Polygon(List<PVector> points) {
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
