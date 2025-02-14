class Tile {

    private ArrayList<Particle> obstacles;
    private int TILE_SIZE;
    private PImage image;
    private PVector position;
    private PGraphics pg;
    private int indexX, indexY;

    public Tile(boolean[] borders, ArrayList<Shape> obstacleShapes, int indexX, int indexY) {
        this.indexX = indexX;
        this.indexY = indexY;
        setObstacles(obstacleShapes);
        addBorders(borders);
    }

    public int getIndexX() {
        return indexX;
    }

    public int getIndexY() {
        return indexY;
    }

    private void addBorders(boolean[] borders) {
        for (int i = 0; i < 4; i++) {
            if (borders[i]) {
                // Case 0 to stop compiler error for uninstantiated s
                Shape s = polyGen.getRectangle(new PVector(0, tileSize), new PVector(tileSize, tileSize - Constants.HOLE_BORDER_WIDTH));
                switch (i) {
                    case 1:
                        s = polyGen.getRectangle(new PVector(0, 0), new PVector(Constants.HOLE_BORDER_WIDTH, tileSize));
                        break;
                    case 2:
                        s = polyGen.getRectangle(new PVector(0, 0), new PVector(tileSize, Constants.HOLE_BORDER_WIDTH));
                        break;
                    case 3:
                        s = polyGen.getRectangle(new PVector(tileSize, 0), new PVector(tileSize - Constants.HOLE_BORDER_WIDTH, tileSize));
                        break;
                }
                obstacles.add(new Particle(s.getPosition(), new PVector(0, 0), new PVector(0, 0, 0), 0, s));
            }
        }
    }

    private void setObstacles(ArrayList<Shape> obstacleShapes) {
        obstacles = new ArrayList<Particle>();
        for (Shape s: obstacleShapes) {
            obstacles.add(new Particle(s.getPosition(), new PVector(0, 0), new PVector(0, 0, 0), 0, s));
        }
    }

    public void setPosition(PVector position) {
        this.position = position;
    }

    public PVector getPosition() {
        return position;
    }

    public void draw(Environment environment) {

        imageMode(CORNER);
        image(pg, position.x, position.y);
    }

    private void init(Environment environment) {
        pg = createGraphics(tileSize, tileSize);
        pg.beginDraw();
        pg.noStroke();
        pg.fill(environment.getGroundColour());
        pg.rect(0, 0, tileSize, tileSize);
        pg.fill(environment.getObstacleColour());
        for (Particle o: obstacles) {
            o.getShape().setImage(pg);
            o.getShape().addOffset(position);
        }
        pg.endDraw();
    }

    public void checkCollisions(Player player) {
        for (Particle o: obstacles) {
            collisionDetect.checkCollision(player, o);
        }
    }
}
