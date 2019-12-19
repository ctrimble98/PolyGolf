class PreDefHoles {

    private PreDefTiles preDefTiles;

    public PreDefHoles() {
        preDefTiles = new PreDefTiles();
    }

    public Hole getBasic1() {
        Tile[][] holeTiles = new Tile[Constants.GRID_SIZE][Constants.GRID_SIZE];

        holeTiles[(Constants.GRID_SIZE - 1)/2][3] = preDefTiles.getBasicStart();
        holeTiles[(Constants.GRID_SIZE - 1)/2][2] = preDefTiles.getEmptyVerticalCorridor();
        holeTiles[(Constants.GRID_SIZE - 1)/2][1] = preDefTiles.getBasicEnd();

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
        return new Hole(holeTiles, tileList, holeTiles[(Constants.GRID_SIZE - 1)/2][3], holeTiles[(Constants.GRID_SIZE - 1)/2][1]);
    }
}
