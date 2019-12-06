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

        for (Tile t: tileList) {
            t.init(environment);
        }
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

    public void checkCollsions(PVector player) {

        //Check current tile

        int[] tile = new int[]{player.x/Constants.TILE_SIZE, player.y/Constants.TILE_SIZE]};
        PVector offSet = player.copy().sub(tile[0], tile[1]);
        boolean xLeft = offset.x < Constants.PLAYER_RADIUS;
        boolean yTop = offset.y < Constants.PLAYER_RADIUS;
        boolean xRight = (offset.x - Constants.TILE_SIZE) < Constants.PLAYER_RADIUS;
        boolean yBottom = (offset.y - Constants.TILE_SIZE) < Constants.PLAYER_RADIUS;
        //Refactor for method from robotron
        if (xLeft) {
            //Check collsion left
            if (yTop) {
                //CheckTop
                //CheckTopLeft
            } else if (yBottom) {
                //CheckBottomLeft
            }
        } else if (xRight) {
            //Check collsion right
            if (yTop) {
                //CheckTop
                //CheckTopRight
            } else if (yBottom) {
                //CheckBottom
                //CheckBottomRight
            }
        } else if (yTop) {
            //CheckTop
        } else if (yBottom) {
            //CheckBottom
        }
    }
}
