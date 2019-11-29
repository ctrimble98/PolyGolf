import java.util.*;

PreDefTiles tiles = new PreDefTiles();

Environment grass = new Environment(
    color(181, 230, 29),
    color(37, 178, 74),
    color(145, 184, 23)
);
Hole hole;

void setup() {
    fullScreen();
    Tile[][] holeTiles = new Tile[Constants.GRID_SIZE][Constants.GRID_SIZE];
    holeTiles[(Constants.GRID_SIZE - 1)/2][3] = tiles.basicStart;
    holeTiles[(Constants.GRID_SIZE - 1)/2][2] = tiles.emptyVerticalCorridor;
    holeTiles[(Constants.GRID_SIZE - 1)/2][1] = tiles.basicEnd;
    hole = new Hole(grass, holeTiles);
}

void draw() {
    hole.draw();
    System.out.println(displayWidth);
}
