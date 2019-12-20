class Cup {

    private PVector position;
    private float radius;

    public Cup(PVector position, float radius) {
        this.position = position;
        this.radius = radius;
    }

    public boolean checkCollision(Particle p) {
        float dist = p.getPosition().dist(position);
        if (dist < radius) {
            println(p.getLinearVel().mag());
            println(20*(1 - dist/radius));
            if (p.getLinearVel().mag() < 20*(1 - dist/radius)) {
                return true;
            }
            return false;
        } else {
            return false;
        }
    }

    public void draw() {
        fill(0);
        circle(position.x,position.y, Constants.CUP_RADIUS*2);
    }
}
