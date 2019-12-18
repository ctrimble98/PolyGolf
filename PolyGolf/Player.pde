class Player extends Particle {

    private PGraphics pg;

    public Player(PVector start, Shape shape) {
        super(start, new PVector(-0.5, -0.5), new PVector(0, 0, 0.05), Constants.PLAYER_INV_MASS, shape);
        this.shape = shape;
        setImage();
        // shape.addOffset(position);
    }

    public void draw() {
        shape.setPosition(position);
        pushMatrix();
        translate(position.x, position.y);
        rotate(orientation.z);
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
}
