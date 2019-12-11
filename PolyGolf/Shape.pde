abstract class Shape {

    private ShapeType type;
    protected PVector position;
    protected float boundingRadius;

    public Shape(ShapeType type, PVector position, float boundingRadius) {
        this.type = type;
        this.position = position;
        this.boundingRadius = boundingRadius;
    }

    public ShapeType getType() {
        return type;
    }

    public PVector getPosition() {
        return position;
    }

    public float getBoundingRadius() {
        return boundingRadius;
    }

    public abstract void setImage(PGraphics pg);
}
