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
}
