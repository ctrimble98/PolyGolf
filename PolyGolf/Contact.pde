class Contact {

    private PVector position;
    private PVector normal;

    public Contact(PVector position, PVector normal) {
        this.position = position;
        this.normal = normal;
    }

    public PVector getPosition() {
        return position;
    }

    public PVector getNormal() {
        return normal;
    }
}
