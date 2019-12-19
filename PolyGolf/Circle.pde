class Circle extends Shape {

    public Circle(PVector position, int radius) {
        super(ShapeType.CIRCLE, position, radius);
        inertia = 0.5*sq(radius);
    }

    public PVector getPosition() {
        return position;
    }

    public float getRadius() {
        return boundingRadius;
    }

    public void setImage(PGraphics pg) {
        pg.ellipseMode(CENTER);
        pg.ellipse(position.x, position.y, boundingRadius, boundingRadius);
    }
}
