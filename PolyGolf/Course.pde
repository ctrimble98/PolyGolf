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
        scores = new int[courseLength + 1][3];
        int totalPar = 0;
        for (int i = 0; i < courseLength; i++) {
            holes.get(i).init(environment);
            scores[i][0] = i + 1;
            scores[i][1] = holes.get(i).getPar();
            totalPar += holes.get(i).getPar();
        }
        scores[courseLength][1] = totalPar;
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
                        text(getHoleResult(player.getShots() - scores[currentHoleIndex][1]), displayWidth/2, displayHeight/2);
                    } else {
                        currentHoleIndex++;
                        startHole();
                    }
                break;
            case RESULTS:
                showResults();
                break;
        }

    }

    public void update(Player p) {
        if (mode == CourseMode.PLAY) {
            player.update();
            if (holes.get(currentHoleIndex).checkCollisions(player)) {
                mode = CourseMode.END;
                scores[currentHoleIndex][2] = player.getShots();
                scores[courseLength][2] += player.getShots();
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

    public void showResults() {
        background(environment.getGroundColour());
        stroke(environment.getObstacleColour());
        strokeWeight(5);
        int boxSize = 50;
        int resultsWidth = (courseLength + 1) * boxSize;

        textAlign(CENTER, CENTER);
        textFont(infoFont, 60);
        fill(environment.getObstacleColour());

        text("Results", displayWidth/2, displayHeight/2 - 3*boxSize);
        textFont(infoFont, 40);

        pushMatrix();
        translate(displayWidth/2 - resultsWidth/2, displayHeight/2 - 3*boxSize/2);
        text("Hole", -3*boxSize/2, boxSize/2);
        text("Par", -3*boxSize/2, 3*boxSize/2);
        text("Score", -3*boxSize/2, 5*boxSize/2);
        for (int i = 0; i < courseLength + 1; i++) {
            for (int j = 0; j < 3; j++) {
                pushMatrix();
                translate(i*boxSize, j*boxSize);
                if (i < courseLength) {
                    fill(0, 0);
                    rect(0, 0, boxSize, boxSize);
                    fill(environment.getObstacleColour());
                    text(scores[i][j], boxSize/2, boxSize/2);
                } else {
                    fill(0, 0);
                    rect(0, 0, boxSize*2, boxSize);
                    fill(environment.getObstacleColour());
                    if (j == 0) {
                        text("T", boxSize, boxSize/2);
                    } else {
                        text(scores[i][j], boxSize, boxSize/2);
                    }
                }
                popMatrix();
            }
        }
        popMatrix();
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
