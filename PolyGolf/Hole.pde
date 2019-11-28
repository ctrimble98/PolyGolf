class Hole {

    private PVector holePos;
    private ArrayList<Tile> tiles;
    private PVector holeTopLeft;
    private PVector holeBottomRight;
    private Environment environment;

    //Random hole
    public Hole(Environment environment) {
        this.environment = environment;
        holePos = new PVector(displayWidth/2, displayHeight/4);
        holeTopLeft = new PVector(3*displayWidth/8, 0);
        holeBottomRight = new PVector(5*displayWidth/8, 7*displayHeight/8);
        obstacles = new ArrayList<Polygon>();
    }

    //Predefined hole
    public Hole(ArrayList<Tile> tiles, Environment environment) {
    this.tiles = tiles;
        this.environment = environment;
        holePos = new PVector(displayWidth/2, displayHeight/4);
    }

    public void draw() {
        background(environment.getBackgroundColour());
        rectMode(CORNERS);
        fill(environment.getGroundColour());
        rect(holeTopLeft.x, holeTopLeft.y, holeBottomRight.x, holeBottomRight.y);
        fill(environment.getObstacleColour());
        for (Tile t: tiles) {
            t.draw();
        }

        fill(0);
        ellipse(holePos.x,holePos.y, 10, 10);
    }
}
