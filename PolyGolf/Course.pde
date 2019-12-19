class Course {

    private Environment environment;
    private List<Hole> holes;
    private int currentHoleIndex;
    private int[][] scores;
    private int courseLength;
    private Player player;
    private int timer;
    private CourseMode mode;
    private boolean holeEnded;

    public Course(List<Hole> holes, Environment environment, Player player) {
        this.holes = holes;
        this.player = player;
        this.environment = environment;
        courseLength = holes.size();
        scores = new int[courseLength][2];
        for (int i = 0; i < courseLength; i++) {
            holes.get(i).init(environment);
            scores[i][0] = holes.get(i).getPar();
        }
        currentHoleIndex = 0;
        startHole();
    }

    public CourseMode getMode() {
        return mode;
    }

    public void drawCourse() {

        switch (mode) {
            case PLAY:
                holes.get(currentHoleIndex).draw();
                player.draw();
                drawHoleStats();
                break;
            case START:
                if (timer > 0) {
                    timer--;
                    background(environment.getGroundColour());
                    fill(environment.getObstacleColour());
                    textAlign(CENTER, CENTER);
                    textFont(infoFont, 60);
                    text("Hole " + (currentHoleIndex + 1), displayWidth/2, displayHeight/2);
                } else {
                    mode = CourseMode.PLAY;
                }
                break;
            case END:
                    if (timer > 0) {
                        timer--;
                        background(environment.getGroundColour());
                        fill(environment.getObstacleColour());
                        textAlign(CENTER, CENTER);
                        textFont(infoFont, 60);
                        text(getHoleResult(player.getShots() - scores[currentHoleIndex][0]), displayWidth/2, displayHeight/2);
                    } else {
                        currentHoleIndex++;
                        startHole();
                    }
                break;
            case RESULTS:
                background(environment.getGroundColour());
                stroke(environment.getObstacleColour());
                int resultsSize = (Constants.GRID_WIDTH - 2)*tileSize;
                int boxSize = resultsSize/courseLength;
                fill(0, 0);
                for (int i = -resultsSize/2; i < resultsSize/2; i += boxSize) {
                    rect(i + displayWidth/2, displayHeight/2 - boxSize/2, boxSize, boxSize);
                }
                break;
        }

    }

    public void update(Player p) {
        if (mode == CourseMode.PLAY) {
            player.update();
            if (holes.get(currentHoleIndex).checkCollisions(player)) {
                mode = CourseMode.END;
                scores[currentHoleIndex][1] = player.getShots();
                timer = Constants.FPS;
            }
            contactResolver.resolveContacts();
        }
    }

    public void drawHoleStats() {
        fill(0);
        textAlign(CENTER, TOP);
        textFont(infoFont, 30);
        text("Hole " + (currentHoleIndex + 1) + " Par " + scores[currentHoleIndex][0] + " Shots " + player.getShots(), displayWidth/2, 0);
    }

    private void startHole() {
        if (currentHoleIndex < courseLength) {
            player.reset(holes.get(currentHoleIndex).getStart());
            mode = CourseMode.START;
            timer = Constants.FPS;
        } else {
            mode = CourseMode.RESULTS;
        }
    }

    private String getHoleResult(int shotDifference) {
        switch (shotDifference) {
            case -3:
                return "Albatross";
            case -2:
                return "Eagle";
            case -1:
                return "Birdie";
            case 0:
                return "Par";
            case 1:
                return "Bogey";
            case 2:
                return "Double Bogey";
            case 3:
                return "Triple Bogey";
            default:
                if (shotDifference < 0) {
                    return "" + shotDifference;
                } else {
                    return "+" + shotDifference;
                }
        }
    }
}
