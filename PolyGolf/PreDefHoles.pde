class PreDefHoles {

    private PreDefTiles preDefTiles;

    public PreDefHoles() {
        preDefTiles = new PreDefTiles();
    }

    private Tile[][] setTilePositions(ArrayList<Tile> tileList) {
        Tile[][] tileArray = new Tile[Constants.GRID_WIDTH][Constants.GRID_HEIGHT];

        for (Tile t: tileList) {
            int x = t.getIndexX();
            int y = t.getIndexY();
            tileArray[x][y] = t;
            t.setPosition(offset.copy().add(new PVector(x*tileSize, y*tileSize)));
        }

        return tileArray;
    }

    public Hole getBasic1() {
        ArrayList<Tile> tileList = new ArrayList<Tile>();
        tileList.add(preDefTiles.getEmpty(2, 3, Borders.U));
        tileList.add(preDefTiles.getEmpty(2, 2, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(2, 1, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(2, 0, Borders.N));

        Tile[][] holeTiles = setTilePositions(tileList);

        return new Hole(holeTiles, tileList, tileList.get(0), tileList.get(tileList.size() - 1), 2);
    }

    public Hole getBasic2() {
        ArrayList<Tile> tileList = new ArrayList<Tile>();
        tileList.add(preDefTiles.getEmpty(3, 3, Borders.U));
        tileList.add(preDefTiles.getEmpty(3, 2, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(3, 1, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(3, 0, Borders.LEFT_TURN_1));
        tileList.add(preDefTiles.getEmpty(2, 0, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(1, 0, Borders.RIGHT_TURN_1));
        tileList.add(preDefTiles.getEmpty(1, 1, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(1, 2, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(1, 3, Borders.U));

        Tile[][] holeTiles = setTilePositions(tileList);

        return new Hole(holeTiles, tileList, tileList.get(0), tileList.get(tileList.size() - 1), 4);
    }

    public Hole getBasic3() {
        ArrayList<Tile> tileList = new ArrayList<Tile>();
        tileList.add(preDefTiles.getEmpty(2, 3, Borders.U));
        tileList.add(preDefTiles.getEmpty(2, 2, Borders.LEFT_TURN_1));
        tileList.add(preDefTiles.getEmpty(1, 2, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(0, 2, Borders.LEFT_TURN_2));
        tileList.add(preDefTiles.getEmpty(0, 1, Borders.RIGHT_TURN_1));
        tileList.add(preDefTiles.getEmpty(1, 1, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(2, 1, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(3, 1, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(4, 1, Borders.RIGHT_TURN_2));
        tileList.add(preDefTiles.getEmpty(4, 0, Borders.LEFT_TURN_1));
        tileList.add(preDefTiles.getEmpty(3, 0, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(2, 0, Borders.C));

        Tile[][] holeTiles = setTilePositions(tileList);

        return new Hole(holeTiles, tileList, tileList.get(0), tileList.get(tileList.size() - 1), 6);
    }

    public Hole getBasic4() {
        ArrayList<Tile> tileList = new ArrayList<Tile>();
        tileList.add(preDefTiles.getEmpty(2, 2, Borders.BACKWARDS_C));
        tileList.add(preDefTiles.getEmpty(1, 2, Borders.LEFT_TURN_2));
        tileList.add(preDefTiles.getEmpty(1, 1, Borders.RIGHT_TURN_1));
        tileList.add(preDefTiles.getEmpty(2, 1, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(3, 1, Borders.LEFT_TURN_1));
        tileList.add(preDefTiles.getEmpty(3, 2, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(3, 3, Borders.RIGHT_TURN_2));
        tileList.add(preDefTiles.getEmpty(2, 3, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(1, 3, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(0, 3, Borders.LEFT_TURN_2));
        tileList.add(preDefTiles.getEmpty(0, 2, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(0, 1, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(0, 0, Borders.RIGHT_TURN_1));
        tileList.add(preDefTiles.getEmpty(1, 0, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(2, 0, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(3, 0, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(4, 0, Borders.LEFT_TURN_1));
        tileList.add(preDefTiles.getEmpty(4, 1, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(4, 2, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(4, 3, Borders.U));

        Tile[][] holeTiles = setTilePositions(tileList);

        return new Hole(holeTiles, tileList, tileList.get(0), tileList.get(tileList.size() - 1), 7);
    }

    public Hole getBasic5() {
        ArrayList<Tile> tileList = new ArrayList<Tile>();
        tileList.add(preDefTiles.getEmpty(2, 3, Borders.U));
        tileList.add(preDefTiles.getHorizontalBeam(2, 2, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getSmallGap(2, 1, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(2, 0, Borders.N));

        Tile[][] holeTiles = setTilePositions(tileList);

        return new Hole(holeTiles, tileList, tileList.get(0), tileList.get(tileList.size() - 1), 3);
    }

    public Hole getBasic6() {
        ArrayList<Tile> tileList = new ArrayList<Tile>();
        tileList.add(preDefTiles.getEmpty(2, 3, Borders.U));
        tileList.add(preDefTiles.getEmpty(2, 2, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(2, 1, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getZigZagTop(2, 0, Borders.TOP));
        tileList.add(preDefTiles.getEmpty(1, 0, Borders.RIGHT_TURN_1));
        tileList.add(preDefTiles.getEmpty(3, 0, Borders.LEFT_TURN_1));
        tileList.add(preDefTiles.getEmpty(1, 1, Borders.LEFT_TURN_2));
        tileList.add(preDefTiles.getEmpty(3, 1, Borders.RIGHT_TURN_2));

        Tile[][] holeTiles = setTilePositions(tileList);

        return new Hole(holeTiles, tileList, tileList.get(0), tileList.get(tileList.size() - 1), 2);
    }

    public Hole getBasic7() {
        ArrayList<Tile> tileList = new ArrayList<Tile>();
        tileList.add(preDefTiles.getEmpty(2, 3, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getSquareObstacle(1, 3, Borders.LEFT_TURN_2));
        tileList.add(preDefTiles.getSquareObstacle(3, 3, Borders.RIGHT_TURN_2));
        tileList.add(preDefTiles.getSquareObstacle(1, 2, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getSquareObstacle(3, 2, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getSquareObstacle(1, 1, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getSquareObstacle(3, 1, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getSquareObstacle(1, 0, Borders.RIGHT_TURN_1));
        tileList.add(preDefTiles.getSquareObstacle(3, 0, Borders.LEFT_TURN_1));
        tileList.add(preDefTiles.getEmpty(2, 0, Borders.HORIZONTAL_CORRIDOR));

        Tile[][] holeTiles = setTilePositions(tileList);

        return new Hole(holeTiles, tileList, tileList.get(0), tileList.get(tileList.size() - 1), 3);
    }

    public Hole getBasic8() {
        ArrayList<Tile> tileList = new ArrayList<Tile>();
        tileList.add(preDefTiles.getEmpty(0, 3, Borders.LEFT_TURN_2));
        tileList.add(preDefTiles.getEmpty(1, 3, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(2, 3, Borders.RIGHT_TURN_2));
        tileList.add(preDefTiles.getEmpty(3, 3, Borders.C));
        tileList.add(preDefTiles.getEmpty(4, 3, Borders.RIGHT_TURN_2));
        tileList.add(preDefTiles.getEmpty(0, 2, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(1, 2, Borders.C));
        tileList.add(preDefTiles.getEmpty(2, 2, Borders.LEFT_TURN_1));
        tileList.add(preDefTiles.getEmpty(3, 2, Borders.LEFT_TURN_2));
        tileList.add(preDefTiles.getEmpty(4, 2, Borders.RIGHT));
        tileList.add(preDefTiles.getEmpty(0, 1, Borders.RIGHT_TURN_1));
        tileList.add(preDefTiles.getEmpty(1, 1, Borders.RIGHT_TURN_2));
        tileList.add(preDefTiles.getEmpty(2, 1, Borders.C));
        tileList.add(preDefTiles.getEmpty(3, 1, Borders.RIGHT));
        tileList.add(preDefTiles.getEmpty(4, 1, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(0, 0, Borders.C));
        tileList.add(preDefTiles.getEmpty(1, 0, Borders.TOP));
        tileList.add(preDefTiles.getEmpty(2, 0, Borders.HORIZONTAL_CORRIDOR));
        tileList.add(preDefTiles.getEmpty(3, 0, Borders.LEFT_TURN_1));
        tileList.add(preDefTiles.getEmpty(4, 0, Borders.N));

        Tile[][] holeTiles = setTilePositions(tileList);

        return new Hole(holeTiles, tileList, tileList.get(0), tileList.get(tileList.size() - 1), 5);
    }

    public Hole getBasic9() {
        ArrayList<Tile> tileList = new ArrayList<Tile>();
        tileList.add(preDefTiles.getEmpty(2, 3, Borders.U));
        tileList.add(preDefTiles.getBottomGapBig(2, 2, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getBottomGapMedium(2, 1, Borders.VERTICAL_CORRIDOR));
        tileList.add(preDefTiles.getBottomGapSmall(2, 0, Borders.N));

        Tile[][] holeTiles = setTilePositions(tileList);

        return new Hole(holeTiles, tileList, tileList.get(0), tileList.get(tileList.size() - 1), 2);
    }
}
