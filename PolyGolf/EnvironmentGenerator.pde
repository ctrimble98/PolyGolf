class EnvironmentGenerator {

    public List<Environment> getEnvironments() {
        List<Environment> environments = new ArrayList<Environment>();
        environments.add(getGrass());
        environments.add(getIce());
        environments.add(getSand());
        return environments;
    }

    public Environment getGrass() {
        return new Environment(
            color(181, 230, 29),
            color(37, 178, 74),
            color(145, 184, 23),
            color(255)
        );
    }

    public Environment getIce() {
        return new Environment(
            color(107, 250, 241),
            color(31, 184, 174),
            color(140, 250, 243),
            color(8, 78, 191)
        );
    }

    public Environment getSand() {
        return new Environment(
            color(255, 237, 176),
            color(148, 137, 98),
            color(176, 163, 118),
            color(38, 34, 20)
        );
    }
}
