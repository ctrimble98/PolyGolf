class Contact {

    private Particle p1;
    private Particle p2;
    private PVector position;
    private PVector normal;
    private float penDepth;

    public Contact(Particle p1, Particle p2, PVector position, PVector normal, float penDepth) {
        this.p1 = p1;
        this.p2 = p2;
        this.position = position;
        this.normal = normal;
        this.penDepth = penDepth;
    }

    public PVector getPosition() {
        return position;
    }

    public PVector getNormal() {
        return normal;
    }

    public void resolve() {



        fill(255);
        ellipse(p1.getPosition().x + position.x, p1.getPosition().y + position.y, 5, 5);
        System.out.println(p1.getLinearVel());
        resolveInterpenetration();
        resolveVelocity();
        resolveAngular();
        // p1.getLinearVel().mult(-1);
        // System.out.println(p1.getLinearVel());
        // System.out.println(p1.getPosition());
        // System.out.println(position);
        System.out.println(penDepth);
        // System.out.println(p2.getPosition());

        System.out.println();
    }

    private void resolveVelocity() {

        // PVector relPos1 = position.copy().sub(p1.getPosition());
        PVector contactVelocity = p1.getLinearVel();
        contactVelocity.add(p1.getAngularVel().copy().cross(position));

        //The position of the contact in relatiopn to p2
        PVector position2 = p1.getPosition().copy().sub(p2.getPosition()).add(position);
        contactVelocity.add(p2.getLinearVel());
        contactVelocity.add(p2.getAngularVel().copy().cross(position2));

        float deltaVelocity = -contactVelocity.x * (1 + Constants.COEFF_OF_RESTITUTION);

        float relativeVelocity = p1.getLinearVel().copy().sub(p2.getLinearVel()).dot(normal);
        float sepVelocity = -1*relativeVelocity*Constants.COEFF_OF_RESTITUTION;

        float changeVelocity = sepVelocity - relativeVelocity;

        float invM1 = p1.getInvMass();
        float invM2 = p2.getInvMass();

        float totalInvMass = invM1 + invM2;
        if (totalInvMass <= 0) {
            return;
        }

        PVector impulsePerInvMass = normal.copy().mult(changeVelocity/totalInvMass);

        p1.setLinearVel(p1.getLinearVel().add(impulsePerInvMass.copy().mult(invM1)));
        p2.setLinearVel(p2.getLinearVel().add(impulsePerInvMass.copy().mult(-1*invM2)));
    }

    private void resolveAngular() {

        PVector relPos = position.copy().sub(p1.getPosition());

        //Only look at z axis since in 2d only spinning about this axis
        float impulsiveTorquePerImpulse = relPos.copy().cross(normal).z;
        float angularChangeperImpulse = sq(relPos.mag())*(impulsiveTorquePerImpulse);


        float relativeVelocity = p1.getLinearVel().copy().sub(p2.getLinearVel()).dot(normal);
        float sepVelocity = -1*relativeVelocity*Constants.COEFF_OF_RESTITUTION;

        float changeVelocity = sepVelocity - relativeVelocity;

        float invM1 = p1.getInvMass();
        float invM2 = p2.getInvMass();

        float totalInvMass = invM1 + invM2;
        if (totalInvMass <= 0) {
            return;
        }

        PVector impulsePerInvMass = normal.copy().mult(changeVelocity/totalInvMass);

        p1.setLinearVel(p1.getLinearVel().add(impulsePerInvMass.copy().mult(invM1)));
        p2.setLinearVel(p2.getLinearVel().add(impulsePerInvMass.copy().mult(-1*invM2)));
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
            p1.getPosition().add(penetrationVector.copy().mult(m2/totalMass));
            p2.getPosition().add(penetrationVector.copy().mult(m1/totalMass).mult(-1));
        }

        // float totalInertia = 0;
        //
        // float[] linearInertia = new float[]{p1.getInvMass(), p2.getInvMass();}
        // totalInertia += linearInertia[0];
        // totalInertia += linearInertia[1];
        //
        // float[] inverseInertiaMoment = new float[]{sq(position.mag())*p1.getInvMass(), sq(p2.getPosition().copy().sub(p1.getPosition()).add(position).mag())*p2.getInvMass();}
        //
        //
        //
        // float inverseInertia = 1/totalInertia;
        // PVector linearMove1 = penDepth*linearInertia1*inverseInertia;
    }
}
