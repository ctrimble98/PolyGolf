class Cup {

    private PVector position;
    private float radius;

    public Cup(PVector position, float radius) {
        this.position = position;
        this.radius  = radius;
    }

    public boolean checkCollision(Particle p) {
        if (p.getPosition().dist(position) < radius) {
            return true;
        } else {
            return false;
        }
    }

    public void draw() {
        fill(0);
        circle(position.x,position.y, Constants.CUP_RADIUS);
    }
}
