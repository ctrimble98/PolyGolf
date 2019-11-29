class Polygon {
    private List<PVector> points;

    public Polygon(List<PVector> points) {
        this.points = points;
    }

    public List<PVector> getPoints() {
        return points;
    }

    public void draw() {
        beginShape();
        for (PVector p: points) {
            vertex(p.x, p.y);
            System.out.println(p);
        }
        endShape(CLOSE);
        System.out.println();
    }
}
