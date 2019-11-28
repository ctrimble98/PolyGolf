class Environment {
    private color groundColour;
    private color obstacleColour;
    private color backgroundColour;

    public Environment(color groundColour, color obstacleColour, color backgroundColour) {
        this.groundColour = groundColour;
        this.obstacleColour = obstacleColour;
        this.backgroundColour = backgroundColour;
    }

    public color getGroundColour() {
        return groundColour;
    }

    public color getObstacleColour() {
        return obstacleColour;
    }

    public color getBackgroundColour() {
        return backgroundColour;
    }
}
