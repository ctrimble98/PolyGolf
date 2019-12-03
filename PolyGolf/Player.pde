class Player extends Particle {

    private PGraphics pg;
    private List<PVector> points;

    public Player(PVector start, ArrayList<PVector> points) {
        this.points = points;
        this.position = start;
        setImage();
    }

    public void draw() {
        imageMode(CENTER);
        image(pg, position.x, position.y);
    }

    private void setImage() {
        pg = createGraphics(2*Constants.PLAYER_RADIUS, 2*Constants.PLAYER_RADIUS);
        pg.beginDraw();
        pg.fill(PLAYER_COLOUR);
        pg.noStroke();
        pg.beginShape();
        for (PVector p: points) {
            pg.vertex(p.x, p.y);
        }
        pg.endShape(CLOSE);
        pg.endDraw();
    }
}
