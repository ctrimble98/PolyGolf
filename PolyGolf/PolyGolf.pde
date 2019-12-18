import java.util.*;

PreDefTiles tiles;
PolygonGenerator polyGen;
CollisionDetector collisionDetect;

List<Contact> contacts;

final color PLAYER_COLOUR = color(255);

PVector offset;

Environment grass = new Environment(
    color(181, 230, 29),
    color(37, 178, 74),
    color(145, 184, 23)
);
Hole hole;
Player player;

public void settings(){
    fullScreen();
}

void setup() {
    tiles = new PreDefTiles();
    polyGen = new PolygonGenerator();
    collisionDetect = new CollisionDetector();

    contacts = new ArrayList<Contact>();

    Tile[][] holeTiles = new Tile[Constants.GRID_SIZE][Constants.GRID_SIZE];

    holeTiles[(Constants.GRID_SIZE - 1)/2][3] = tiles.getBasicStart();
    holeTiles[(Constants.GRID_SIZE - 1)/2][2] = tiles.getEmptyVerticalCorridor();
    holeTiles[(Constants.GRID_SIZE - 1)/2][1] = tiles.getBasicEnd();
    // holeTiles[(Constants.GRID_SIZE - 1)/2 - 1][2] = tiles.getEmptyVerticalCorridor();
    // holeTiles[(Constants.GRID_SIZE - 1)/2 - 1][3] = tiles.getEmptyVerticalCorridor();

    ArrayList<Tile> tileList = new ArrayList<Tile>();
    float halfGridSize = Constants.TILE_SIZE*Constants.GRID_SIZE/2;
    offset = new PVector(displayWidth/2 - halfGridSize, displayHeight/2 - halfGridSize);
    for (int i = 0; i < Constants.GRID_SIZE; i++) {
        for (int j = 0; j < Constants.GRID_SIZE; j++) {
            if (holeTiles[i][j] != null) {
                holeTiles[i][j].setPosition(offset.copy().add(new PVector(i*Constants.TILE_SIZE, j*Constants.TILE_SIZE)));
                tileList.add(holeTiles[i][j]);
            }
        }
    }
    hole = new Hole(grass, holeTiles, tileList, holeTiles[(Constants.GRID_SIZE - 1)/2][3], holeTiles[(Constants.GRID_SIZE - 1)/2][1]);
    //player = new Player(hole.getStart(), polyGen.getRegularPolygon(3, Constants.PLAYER_RADIUS, PI/4, new PVector(Constants.PLAYER_RADIUS, Constants.PLAYER_RADIUS)));
    player = new Player(hole.getStart(), polyGen.getRegularStar(3, 1, Constants.PLAYER_RADIUS, PI/4, new PVector(Constants.PLAYER_RADIUS, Constants.PLAYER_RADIUS)));
}

void draw() {
    hole.draw();
    player.update();
    player.draw();
    hole.checkCollisions(player);
    drawStats();
}

public void drawStats() {
    fill(0);
    textAlign(LEFT, TOP);
    text(frameRate, 0, 0);
}
