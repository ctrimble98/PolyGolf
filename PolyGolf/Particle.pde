class Particle {

    protected PVector position;
    private PVector linearV;
    protected float orientation, angularV;
    protected Shape shape;
    private float mass, invMass;

    public PVector getPosition() {
        return position;
    }

    public void setPosition(PVector position) {
        this.position = position;
    }

    public PVector getLinearVel() {
        return linearV;
    }

    public void setLinearVel(PVector linearV) {
        this.linearV = linearV;
    }

    public Particle(PVector position, float invMass, Shape shape) {
        this.position = position;
        this.invMass = invMass;
        this.shape = shape;
        orientation = 0;
        linearV = new PVector(-0.5, -0.5);
        angularV = 0.05;
    }

    public void integrate() {
        position.add(linearV);
    }

    //Taken from example from lectures
    protected void updateOrientation() {

        orientation += angularV;

        // Keep in bounds
        if (orientation > PI) {
            orientation -= 2*PI;
        } else if (orientation < -PI) {
            orientation += 2*PI;
        }
    }

    public void update() {
        integrate();
        updateOrientation();
        shape.setPosition(position);
    }

    public Shape getShape() {
        return shape;
    }
}
