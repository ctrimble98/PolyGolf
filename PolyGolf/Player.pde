class Player extends Particle {

    private PGraphics pg;
    private Shape shape;
    private List<PVector> points;

    public Player(PVector start, Shape shape) {
        super(start);
        this.points = points;
        this.shape = shape;
        setImage();
        shape.addOffset(position);
    }

    public void draw() {
        shape.setPosition(position);
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
        shape.setImage(pg);
        pg.endDraw();
    }

    public Shape getShape() {
        return shape;
    }
}
