class Polygon {
    private ArrayList<PVector> points;

    public Polygon(ArrayList<PVector> points) {
        this.points = points;
    }

    public ArrayList<PVector> getPoints() {
        return points;
    }

    public void draw() {
        beginShape();
        for (PVector p: points) {
            vertex(p.x, p.y);
        }
        endShape(CLOSE);
    }
}
