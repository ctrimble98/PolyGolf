class Hole {

    private PVector holePos;
    private Tile[][] tiles;
    private ArrayList<Tile> tileList;
    private PVector holeTopLeft;
    private PVector holeBottomRight;
    private Environment environment;

    //Random hole
    public Hole(Environment environment) {
        this.environment = environment;
        holePos = new PVector(displayWidth/2, displayHeight/4);
        holeTopLeft = new PVector(3*displayWidth/8, 0);
        holeBottomRight = new PVector(5*displayWidth/8, 7*displayHeight/8);
        tiles = new Tile[Constants.GRID_SIZE][Constants.GRID_SIZE];
    }

    //Predefined hole
    public Hole(Environment environment, Tile[][] tiles) {
        this.tiles = tiles;
        this.environment = environment;
        tileList = new ArrayList<Tile>();
        float offset = Constants.TILE_SIZE*Constants.GRID_SIZE/2;
        PVector basePosition = new PVector(displayWidth/2 - offset, displayHeight/2 - offset);
        for (int i = 0; i < Constants.GRID_SIZE; i++) {
            for (int j = 0; j < Constants.GRID_SIZE; j++) {
                if (tiles[i][j] != null) {
                    tiles[i][j].setPosition(basePosition.copy().add(new PVector(i*Constants.TILE_SIZE, j*Constants.TILE_SIZE)));
                    tileList.add(tiles[i][j]);
                }
            }
        }
        holePos = new PVector(displayWidth/2, displayHeight/4);
    }

    public void draw() {
        background(environment.getBackgroundColour());
        noStroke();

        for (Tile t: tileList) {
            t.draw(environment);
        }

        fill(0);
        ellipse(holePos.x,holePos.y, 10, 10);
    }
}
