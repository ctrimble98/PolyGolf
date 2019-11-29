class Player extends Polygon {

    public Player(PVector start, ArrayList<PVector> points) {
        super(points);
    }

    public void draw() {
        fill(PLAYER_COLOUR);
        super.draw();
    }
}
