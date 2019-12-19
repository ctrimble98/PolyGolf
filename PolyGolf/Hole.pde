class Hole {

    private Cup cup;
    private PVector startPos;
    private Tile[][] tiles;
    private ArrayList<Tile> tileList;
    private Environment environment;

    // //Random hole
    // public Hole(Environment environment) {
    //     this.environment = environment;
    //     //holePos = new PVector(displayWidth/2, displayHeight/4);
    //     tiles = new Tile[Constants.GRID_SIZE][Constants.GRID_SIZE];
    // }

    //Predefined hole
    public Hole(Tile[][] tiles, ArrayList<Tile> tileList, Tile start, Tile end) {
        this.tiles = tiles;
        this.tileList = tileList;
        cup = new Cup(end.getPosition().copy().add(Constants.TILE_SIZE/2, Constants.TILE_SIZE/2), Constants.CUP_RADIUS);
        startPos = start.getPosition().copy().add(Constants.TILE_SIZE/2, Constants.TILE_SIZE/2);
    }

    public void draw() {
        background(environment.getBackgroundColour());
        noStroke();

        for (Tile t: tileList) {
            t.draw(environment);
        }

        cup.draw();
    }

    public void init(Environment e) {
        environment = e;
        for (Tile t: tileList) {
            t.init(environment);
        }
    }

    public PVector getStart() {
        return startPos;
    }

    public void checkCollisions(Player player) {

        ArrayList<Tile> collisionTiles = getTilesInRadius(player.getPosition().copy(), Constants.PLAYER_RADIUS);

        for (Tile t: collisionTiles) {
            if (t != null) {
                t.checkCollisions(player);
            }
        }

        cup.checkCollision(player);
    }

    private ArrayList<Tile> getTilesInRadius(PVector position, int radius) {
        position.sub(offset);
        int x = (int)position.x/Constants.TILE_SIZE;
        int y = (int)position.y/Constants.TILE_SIZE;
        PVector tileTopLeftOffset = position.copy().sub(x*Constants.TILE_SIZE, y*Constants.TILE_SIZE);
        PVector tileBottomRightOffset = tileTopLeftOffset.copy().mult(-1).add(Constants.TILE_SIZE, Constants.TILE_SIZE);

        boolean xLeft = tileTopLeftOffset.x < radius;
        boolean yTop = tileTopLeftOffset.y < radius;
        boolean xRight = tileBottomRightOffset.x < radius;
        boolean yBottom = tileBottomRightOffset.y < radius;

        ArrayList<Tile> collisionTiles = new ArrayList<Tile>();
        collisionTiles.add(tiles[x][y]);

        //Refactor for method from robotron
        if (xLeft) {
            //Check collision left
            collisionTiles.add(tiles[x-1][y]);
            if (yTop) {
                //CheckTop
                collisionTiles.add(tiles[x][y-1]);
                //CheckTopLeft
                if (sq(tileTopLeftOffset.x) + sq(tileTopLeftOffset.y) <= sq(radius)) {
                    collisionTiles.add(tiles[x-1][y-1]);
                }
            } else if (yBottom) {
                //CheckBottom
                collisionTiles.add(tiles[x][y+1]);
                //CheckBottomLeft
                if (sq(tileTopLeftOffset.x) + sq(tileBottomRightOffset.y) <= sq(radius)) {
                    collisionTiles.add(tiles[x-1][y+1]);
                }
            }
        } else if (xRight) {
            //Check collision right
            collisionTiles.add(tiles[x+1][y]);
            if (yTop) {
                //CheckTop
                collisionTiles.add(tiles[x][y-1]);
                //CheckTopRight
                if (sq(tileBottomRightOffset.x) + sq(tileTopLeftOffset.y) <= sq(radius)) {
                    collisionTiles.add(tiles[x+1][y-1]);
                }
            } else if (yBottom) {
                //CheckBottom
                collisionTiles.add(tiles[x][y+1]);
                //CheckBottomRight
                if (sq(tileBottomRightOffset.x) + sq(tileBottomRightOffset.y) <= sq(radius)) {
                    collisionTiles.add(tiles[x+1][y+1]);
                }
            }
        } else if (yTop) {
            //CheckTop
            collisionTiles.add(tiles[x][y-1]);
        } else if (yBottom) {
            //CheckBottom
            collisionTiles.add(tiles[x][y+1]);
        }

        return collisionTiles;
    }
}
