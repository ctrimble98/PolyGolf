class PreDefTiles {

    public boolean[] bordersU;
    public boolean[] bordersN;
    public boolean[] bordersC;
    public boolean[] bordersBackwardsC;
    public boolean[] bordersVerticalCorridor;
    public boolean[] bordersHorizontalCorridor;
    public boolean[] bordersLeftTurn1;
    public boolean[] bordersLeftTurn2;
    public boolean[] bordersRightTurn1;
    public boolean[] bordersRightTurn2;
    public boolean[] bordersLeft;
    public boolean[] bordersRight;
    public boolean[] bordersTop;
    public boolean[] bordersBottom;
    public boolean[] bordersNone;

    public PreDefTiles() {
        bordersU = new boolean[]{true, true, false, true};
        bordersN = new boolean[]{false, true, true, true};
        bordersC = new boolean[]{true, true, true, false};
        bordersBackwardsC = new boolean[]{true, false, true, true};
        bordersVerticalCorridor = new boolean[]{false, true, false, true};
        bordersHorizontalCorridor = new boolean[]{true, false, true, false};
        bordersLeftTurn1 = new boolean[]{false, false, true, true};
        bordersLeftTurn2 = new boolean[]{true, true, false, false};
        bordersRightTurn1 = new boolean[]{false, true, true, false};
        bordersRightTurn2 = new boolean[]{true, false, false, true};
        bordersLeft = new boolean[]{false, true, false, false};
        bordersRight = new boolean[]{false, false, false, true};
        bordersTop = new boolean[]{false, false, true, false};
        bordersBottom = new boolean[]{true, false, false, false};
        bordersNone = new boolean[]{false, false, false, false};
    }

    private boolean[] getBorders(Borders b) {
        switch (b) {
            case U:
                return bordersU;
            case N:
                return bordersN;
            case C:
                return bordersC;
            case BACKWARDS_C:
                return bordersBackwardsC;
            case VERTICAL_CORRIDOR:
                return bordersVerticalCorridor;
            case HORIZONTAL_CORRIDOR:
                return bordersHorizontalCorridor;
            case LEFT_TURN_1:
                return bordersLeftTurn1;
            case LEFT_TURN_2:
                return bordersLeftTurn2;
            case RIGHT_TURN_1:
                return bordersRightTurn1;
            case RIGHT_TURN_2:
                return bordersRightTurn2;
            case LEFT:
                return bordersLeft;
            case RIGHT:
                return bordersRight;
            case TOP:
                return bordersTop;
            case BOTTOM:
                return bordersBottom;
            default:
                return bordersNone;
        }
    }

    public Tile getEmpty(int indexX, int indexY, Borders b) {
        return new Tile(getBorders(b), new ArrayList<Shape>(), indexX, indexY);
    }

    public Tile getHorizontalBeam(int indexX, int indexY, Borders b) {
        ArrayList<Shape> obstacles = new ArrayList<Shape>();
        obstacles.add(polyGen.getRectangle(new PVector(tileSize/4, tileSize/2 - 10), new PVector(3*tileSize/4, tileSize/2 + 10)));
        return new Tile(getBorders(b), obstacles, indexX, indexY);
    }

    public Tile getSmallGap(int indexX, int indexY, Borders b) {
        ArrayList<Shape> obstacles = new ArrayList<Shape>();
        obstacles.add(polyGen.getRectangle(new PVector(0, tileSize/2 - 10), new PVector(tileSize/3, tileSize/2 + 10)));
        obstacles.add(polyGen.getRectangle(new PVector(2*tileSize/3, tileSize/2 - 10), new PVector(tileSize, tileSize/2 + 10)));
        return new Tile(getBorders(b), obstacles, indexX, indexY);
    }

    public Tile getBottomGapSmall(int indexX, int indexY, Borders b) {
        ArrayList<Shape> obstacles = new ArrayList<Shape>();
        obstacles.add(polyGen.getRectangle(new PVector(0, tileSize - 20), new PVector(2*tileSize/5, tileSize)));
        obstacles.add(polyGen.getRectangle(new PVector(3*tileSize/5, tileSize - 20), new PVector(tileSize, tileSize)));
        return new Tile(getBorders(b), obstacles, indexX, indexY);
    }

    public Tile getBottomGapMedium(int indexX, int indexY, Borders b) {
        ArrayList<Shape> obstacles = new ArrayList<Shape>();
        obstacles.add(polyGen.getRectangle(new PVector(0, tileSize - 20), new PVector(tileSize/3, tileSize)));
        obstacles.add(polyGen.getRectangle(new PVector(2*tileSize/3, tileSize - 20), new PVector(tileSize, tileSize)));
        return new Tile(getBorders(b), obstacles, indexX, indexY);
    }

    public Tile getBottomGapBig(int indexX, int indexY, Borders b) {
        ArrayList<Shape> obstacles = new ArrayList<Shape>();
        obstacles.add(polyGen.getRectangle(new PVector(0, tileSize - 20), new PVector(tileSize/4, tileSize)));
        obstacles.add(polyGen.getRectangle(new PVector(3*tileSize/4, tileSize - 20), new PVector(tileSize, tileSize)));
        return new Tile(getBorders(b), obstacles, indexX, indexY);
    }

    public Tile getZigZagTop(int indexX, int indexY, Borders b) {
        ArrayList<Shape> obstacles = new ArrayList<Shape>();
        obstacles.add(polyGen.getRectangle(new PVector(tileSize/2 - 10, 0), new PVector(tileSize/2 + 10, tileSize/2)));
        obstacles.add(polyGen.getRectangle(new PVector(0, tileSize/2), new PVector(20, tileSize)));
        obstacles.add(polyGen.getRectangle(new PVector(tileSize - 20, tileSize/2), new PVector(tileSize, tileSize)));
        return new Tile(getBorders(b), obstacles, indexX, indexY);
    }

    public Tile getSquareObstacle(int indexX, int indexY, Borders b) {
        ArrayList<Shape> obstacles = new ArrayList<Shape>();
        int squareRadius = 40;
        obstacles.add(polyGen.getRectangle(new PVector(tileSize/2 - squareRadius, tileSize/2 - squareRadius), new PVector(tileSize/2 + squareRadius, tileSize/2 + squareRadius)));
        return new Tile(getBorders(b), obstacles, indexX, indexY);
    }
}
