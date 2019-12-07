class Tile {

    private ArrayList<Polygon> obstacles;
    private int TILE_SIZE;
    private PImage image;
    private PVector position;
    private PGraphics pg;

    public Tile(boolean[] borders, ArrayList<Polygon> obstacles) {
        this.obstacles = obstacles;
        addBorders(borders);
    }

    private void addBorders(boolean[] borders) {
        for (int i = 0; i < 4; i++) {
            if (borders[i]) {
                switch (i) {
                    case 0:
                        obstacles.add(new Polygon(PolygonGenerator.getRectangle(new PVector(0, Constants.TILE_SIZE), new PVector(Constants.TILE_SIZE, Constants.TILE_SIZE - Constants.HOLE_BORDER_WIDTH))));
                        break;
                    case 1:
                        obstacles.add(new Polygon(PolygonGenerator.getRectangle(new PVector(0, 0), new PVector(Constants.HOLE_BORDER_WIDTH, Constants.TILE_SIZE))));
                        break;
                    case 2:
                        obstacles.add(new Polygon(PolygonGenerator.getRectangle(new PVector(0, 0), new PVector(Constants.TILE_SIZE, Constants.HOLE_BORDER_WIDTH))));
                        break;
                    case 3:
                        obstacles.add(new Polygon(PolygonGenerator.getRectangle(new PVector(Constants.TILE_SIZE, 0), new PVector(Constants.TILE_SIZE - Constants.HOLE_BORDER_WIDTH, Constants.TILE_SIZE))));
                        break;
                }
            }
        }
    }

    public void setPosition(PVector position) {
        this.position = position;
    }

    public PVector getPosition() {
        return position;
    }

    public void draw(Environment environment) {
        // pushMatrix();
        // translate(position.x, position.y);
        // fill(environment.getGroundColour());
        // rect(0, 0, Constants.TILE_SIZE, Constants.TILE_SIZE);
        // fill(environment.getObstacleColour());
        // for (Polygon o: obstacles) {
        //     o.draw();
        // }
        // popMatrix();
        imageMode(CORNER);
        image(pg, position.x, position.y);
    }

    private void init(Environment environment) {
        pg = createGraphics(Constants.TILE_SIZE, Constants.TILE_SIZE);
        pg.beginDraw();
        pg.noStroke();
        pg.fill(environment.getGroundColour());
        pg.rect(0, 0, Constants.TILE_SIZE, Constants.TILE_SIZE);
        pg.fill(environment.getObstacleColour());
        for (Polygon o: obstacles) {
            o.setImage(pg);
        }
        pg.endDraw();
    }

    public void checkCollisions(Player player) {
        PVector playerRelPosition = player.getPosition().copy().sub(position);
        for (Polygon o: obstacles) {
            if (PhysicsEngine.checkCollsionCircPoly(playerRelPosition, Constants.PLAYER_RADIUS, o.getPoints())) {
                System.out.println("TEST");
                background(255);
            }
        }
    }
}
