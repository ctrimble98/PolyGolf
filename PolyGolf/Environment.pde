class Environment {
    private color groundColour;
    private color obstacleColour;
    private color backgroundColour;
    private color playerColour;

    public Environment(color groundColour, color obstacleColour, color backgroundColour, color playerColour) {
        this.groundColour = groundColour;
        this.obstacleColour = obstacleColour;
        this.backgroundColour = backgroundColour;
        this.playerColour = playerColour;
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

    public color getPlayerColour() {
        return playerColour;
    }
}
