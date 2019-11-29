class Hole {

    private PVector holePos;
    private PVector startPos;
    private Tile[][] tiles;
    private ArrayList<Tile> tileList;
    private Environment environment;

    //Random hole
    public Hole(Environment environment) {
        this.environment = environment;
        holePos = new PVector(displayWidth/2, displayHeight/4);
        tiles = new Tile[Constants.GRID_SIZE][Constants.GRID_SIZE];
    }

    //Predefined hole
    public Hole(Environment environment, ArrayList<Tile> tileList, Tile start, Tile end) {
        this.tileList = tileList;
        this.environment = environment;
        holePos = end.getPosition().copy().add(Constants.TILE_SIZE/2, Constants.TILE_SIZE/2);
        startPos = start.getPosition().copy().add(Constants.TILE_SIZE/2, Constants.TILE_SIZE/2);
    }

    public void draw() {
        background(environment.getBackgroundColour());
        noStroke();

        for (Tile t: tileList) {
            t.draw(environment);
        }

        fill(0);
        ellipse(holePos.x,holePos.y, Constants.HOLE_RADIUS, Constants.HOLE_RADIUS);
    }

    public PVector getStart() {
        return startPos;
    }
}
