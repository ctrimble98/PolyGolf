abstract class Particle {

    protected PVector position;
    private PVector linearV;
    protected float orientation, angularV;
    private float mass, invMass;

    public PVector getPosition() {
        return position;
    }

    public void setPosition(PVector position) {
        this.position = position;
    }

    public Particle(PVector position, float invMass) {
        this.position = position;
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
    }

    public void addCollision(Contact contact) {
        // linearV.mult(linearV.copy().mult(-1).dot(position.copy().sub(collision).normalize()));
        linearV
    }
}
