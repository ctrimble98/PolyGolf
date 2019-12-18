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

    void draw() {
        fill(255);
        ellipse(p1.getPosition().x + position.x, p1.getPosition().y + position.y, 5, 5);
        System.out.println(p1.getLinearVel());
        p1.getPosition().add(normal.copy().add(penDepth, penDepth));
        p1.getLinearVel().mult(-1);
        System.out.println(p1.getLinearVel());
        System.out.println(p1.getPosition());
        System.out.println(position);
        System.out.println(p2.getPosition());

        System.out.println();
    }
}
