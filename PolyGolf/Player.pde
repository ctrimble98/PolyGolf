class Player extends Particle {

    private PGraphics pg;
    private int shots;

    public Player(Shape shape) {
        // super(start, new PVector(-2, -2), new PVector(0, 0, 0.05), Constants.PLAYER_INV_MASS, shape);
        super(new PVector(-1, -1), new PVector(0,0), new PVector(0, 0, 0), Constants.PLAYER_INV_MASS, shape);
        this.shape = shape;
        setImage();
    }

    public void reset(PVector position) {
        this.position = position;
        orientation = new PVector(0, 0, 0);
        linearV = new PVector(0, 0);
        angularV = new PVector(0, 0, 0);
        shots = 0;
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
        pg.fill(environments.get(currentEnvironmentIndex).getPlayerColour());
        pg.noStroke();
        shape.setImage(pg);
        pg.endDraw();
    }

    public boolean isStopped() {
        return linearV.copy().add(angularV).mag() == 0;
    }

    public void addShot() {
        shots++;
    }

    public int getShots() {
        return shots;
    }
}
