abstract class Shape {

    private ShapeType type;
    protected PVector position;
    protected float orientation;
    protected float boundingRadius;
    protected float inertia;

    public Shape(ShapeType type, PVector position, float boundingRadius) {
        this.type = type;
        this.position = position;
        this.boundingRadius = boundingRadius;
        orientation = 0;
    }

    public ShapeType getType() {
        return type;
    }

    public void setPosition(PVector position) {
        this.position = position;
    }

    public PVector getPosition() {
        return position;
    }

    public float getBoundingRadius() {
        return boundingRadius;
    }

    public float getInertia() {
        return inertia;
    }

    public void addOffset(PVector offset) {
        position.add(offset);
    }

    public abstract void setImage(PGraphics pg);

    public void update(PVector position, float orientation) {
        this.position = position;
        this.orientation = orientation;
    }
}
