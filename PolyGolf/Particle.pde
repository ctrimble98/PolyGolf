class Particle {

    protected PVector position;
    protected PVector linearV, linearA;
    protected PVector orientation, angularV, angularA;
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

    public PVector getAngularVel() {
        return angularV;
    }

    public void setAngularVel(PVector AngularV) {
        this.angularV = AngularV;
    }

    public float getInvMass() {
        return invMass;
    }

    public float getMass() {
        return mass;
    }

    public Particle(PVector position, PVector linearV, PVector angularV, float invMass, Shape shape) {
        this.position = position;
        this.linearV = linearV;
        this.angularV = angularV;
        this.invMass = invMass;
        this.shape = shape;
        orientation = new PVector(0, 0, 0);
        linearA = new PVector(0, 0);
        angularA = new PVector(0, 0, 0);
        if (invMass > 0) {
            mass = 1/invMass;
        }
    }

    public void integrate() {

        linearV.add(linearA);
        position.add(linearV.copy().normalize().mult(min(linearV.mag(), 10)));
        if (linearV.copy().mag() < 0.2 && angularV.mag() < 0.03) {
            linearV = new PVector(0, 0);
            angularV = new PVector(0, 0, 0);
        }
    }

    //Taken from example from lectures
    protected void updateOrientation() {

        angularV.add(angularA);
        orientation.add(angularV);

        // Keep in bounds
        if (orientation.z > PI) {
            orientation.z -= 2*PI;
        } else if (orientation.z < -PI) {
            orientation.z += 2*PI;
        }
    }

    public void update() {
        integrate();
        updateOrientation();
        shape.update(position, orientation.z);

        linearV.mult(Constants.LINEAR_DAMPING_FACTOR);
        angularV.mult(Constants.ANGULAR_DAMPING_FACTOR);

        linearA = new PVector(0, 0);
        angularA = new PVector(0, 0, 0);
    }

    public Shape getShape() {
        return shape;
    }

    public float getInertia() {
        if (invMass > 0) {
            return shape.getInertia()*mass;
        } else {
            return 0;
        }
    }

    public void addForce(PVector origin, PVector force) {
        if (invMass > 0) {
            PVector torque = origin.sub(position).cross(force);
            angularA.add(new PVector(0, 0, min(torque.mult(1/getInertia()).z, 0.4)));
            linearA.add(force.copy().mult(invMass).normalize().mult(min(force.copy().mult(invMass).mag(), 20)));
        }
    }
}
