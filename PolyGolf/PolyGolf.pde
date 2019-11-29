import java.util.*;

PreDefTiles tiles = new PreDefTiles();

final color PLAYER_COLOUR = color(255);

Environment grass = new Environment(
    color(181, 230, 29),
    color(37, 178, 74),
    color(145, 184, 23)
);
Hole hole;
Player player;

void setup() {
    fullScreen();
    Tile[][] holeTiles = new Tile[Constants.GRID_SIZE][Constants.GRID_SIZE];

    holeTiles[(Constants.GRID_SIZE - 1)/2][3] = tiles.basicStart;
    holeTiles[(Constants.GRID_SIZE - 1)/2][2] = tiles.emptyVerticalCorridor;
    holeTiles[(Constants.GRID_SIZE - 1)/2][1] = tiles.basicEnd;

    ArrayList<Tile> tileList = new ArrayList<Tile>();
    float offset = Constants.TILE_SIZE*Constants.GRID_SIZE/2;
    PVector basePosition = new PVector(displayWidth/2 - offset, displayHeight/2 - offset);
    for (int i = 0; i < Constants.GRID_SIZE; i++) {
        for (int j = 0; j < Constants.GRID_SIZE; j++) {
            if (holeTiles[i][j] != null) {
                holeTiles[i][j].setPosition(basePosition.copy().add(new PVector(i*Constants.TILE_SIZE, j*Constants.TILE_SIZE)));
                tileList.add(holeTiles[i][j]);
            }
        }
    }
    hole = new Hole(grass, tileList, holeTiles[(Constants.GRID_SIZE - 1)/2][3], holeTiles[(Constants.GRID_SIZE - 1)/2][1]);
    player = new Player(hole.getStart(), PolygonGenerator.getRegularPolygon(4, Constants.PLAYER_RADIUS, PI/4, hole.getStart()));
}

void draw() {
    hole.draw();
    player.draw();
}
