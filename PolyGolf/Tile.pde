class Tile {

    private ArrayList<Polygon> obstacles;
    private int tileSize;
    private Image image;

    public Tile(int tileSize, boolean[] borders, ArrayList<Polygon> obstacles) {
        pushMatrix();
        rotate(PI);
        for (int i = 0; i < 4; i++) {
            if (borders[i]) {
                obstacles.add(PolygonGenerator.getRectangle(new PVector(0, 0), new PVector(tileSize, holeBorderWdith)));
            }
            rotate(PI/2);
        }
        popMatrix();
    }
}
