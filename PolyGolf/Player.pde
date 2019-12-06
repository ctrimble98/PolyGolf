class Player extends Particle {

    private PGraphics pg;
    private List<PVector> points;

    public Player(PVector start, ArrayList<PVector> points) {
        super(start);
        this.points = points;
        setImage();
    }

    public void draw() {
        pushMatrix();
        translate(position.x, position.y);
        rotate(orientation);
        imageMode(CENTER);
        image(pg, 0, 0);
        popMatrix();
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
