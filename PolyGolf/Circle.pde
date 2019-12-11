class Circle extends Shape {

    public Circle(PVector position, int radius) {
        super(ShapeType.CIRCLE, position, radius);
    }

    public PVector getPosition() {
        return position;
    }

    public float getRadius() {
        return boundingRadius;
    }

    public void setImage(PGraphics pg) {
        pg.circle(position.x, position.y, boundingRadius);
    }
}
