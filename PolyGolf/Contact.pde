class Contact {

    private Particle p1;
    private Particle p2;
    private PVector position1;
    private PVector position2;
    private PVector normal;
    private float penDepth;

    public Contact(Particle p1, Particle p2, PVector position1, PVector normal, float penDepth) {
        this.p1 = p1;
        this.p2 = p2;
        this.position1 = position1;
        position2 = p1.getPosition().copy().sub(p2.getPosition()).add(position1);
        this.normal = normal;
        this.penDepth = penDepth;
    }

    public PVector getPosition() {
        return position1;
    }

    public PVector getNormal() {
        return normal;
    }

    public void resolve() {

        resolveInterpenetration();
        resolveVelocity();
    }

    private void resolveVelocity() {

        float desiredChangeVelocity = getDesiredChangeVelocity();

        float invM1 = p1.getInvMass();
        float invM2 = p2.getInvMass();

        PVector changeVel1;
        PVector changeVel2;

        if (invM1 > 0) {
            changeVel1 = position1.copy().cross(normal);
            changeVel1.z = (1/p1.getInertia())*position1.mag();
            changeVel1.cross(position1);
        } else {
            changeVel1 = new PVector(0,0,0);
        }

        float changeVelocity = changeVel1.dot(normal);
        changeVelocity += invM1;

        if (invM2 > 0) {
            changeVel2 = position1.copy().cross(normal);
            changeVel2.z = (1/p2.getInertia())*position2.mag();
            changeVel2.cross(position2);
        } else {
            changeVel2 = new PVector(0,0,0);
        }

        changeVelocity += changeVel2.dot(normal);
        changeVelocity += invM2;

        float impulseRequired = desiredChangeVelocity/changeVelocity;

        PVector impulse = normal.copy().mult(impulseRequired);

        p1.setLinearVel(p1.getLinearVel().add(impulse.copy().mult(invM1)));

        if (p1.getInvMass() > 0) {
            PVector impulsiveTorque = position1.cross(impulse);
            p1.getAngularVel().add(impulsiveTorque.mult(1/p1.getInertia()));
        }

        impulse.mult(-1);
        p2.getLinearVel().add(impulse.copy().mult(invM2));

        if (p2.getInvMass() > 0) {
            PVector impulsiveTorque = impulse.cross(position2);
            p2.getAngularVel().add(impulsiveTorque.mult(1/p2.getInertia()));
        }
    }

    private float getDesiredChangeVelocity() {
        PVector contactVelocity = p1.getLinearVel().copy();
        contactVelocity.add(p1.getAngularVel().copy().cross(position1));

        contactVelocity.add(p2.getLinearVel());
        contactVelocity.add(p2.getAngularVel().copy().cross(position2));

        return -(contactVelocity.dot(normal)/normal.mag()) * (1 + Constants.COEFF_OF_RESTITUTION);
    }
    private void resolveInterpenetration() {

        float invM1 = p1.getInvMass();
        float invM2 = p2.getInvMass();

        PVector posUpdateP1 = new PVector(0, 0);
        PVector posUpdateP2;

        PVector penetrationVector = normal.copy().mult(penDepth);

        if (invM1 == 0 && invM2 == 0) {
            p1.getPosition().add(penetrationVector.copy().mult(0.5));
            p2.getPosition().add(penetrationVector.copy().mult(0.5).mult(-1));
        } else if (invM1 == 0) {
            p2.getPosition().add(penetrationVector.copy().mult(-1));
        } else if (invM2 == 0) {
            p1.getPosition().add(penetrationVector.copy());
        } else {
            float m1 = p1.getMass();
            float m2 = p2.getMass();
            float totalMass = m1 + m2;
            p1.getPosition().add(penetrationVector.copy().mult(m2/totalMass).mult(1.01));
            p2.getPosition().add(penetrationVector.copy().mult(m1/totalMass).mult(-1));
        }
    }
}
