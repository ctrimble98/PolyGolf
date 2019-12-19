class Course {

    private List<Hole> holes;
    private int currentHoleIndex;
    private int[] holeScores;
    private Player player;

    public Course(List<Hole> holes, Environment environment, Player player) {
        this.holes = holes;
        this.player = player;
        holeScores = new int[holes.size()];
        for (Hole h: holes) {
            h.init(environment);
        }
        currentHoleIndex = 0;
        startHole();
    }

    public void drawCourse() {
        holes.get(currentHoleIndex).draw();
        player.draw();
        drawHoleStats();
    }

    public void update(Player p) {
        player.update();
        holes.get(currentHoleIndex).checkCollisions(player);
        contactResolver.resolveContacts();
    }

    public void drawHoleStats() {
        fill(0);
        textAlign(CENTER, TOP);
        text(player.getShots(), displayWidth/2, 0);
    }

    private void startHole() {
        player.reset(holes.get(currentHoleIndex).getStart());
    }
}
