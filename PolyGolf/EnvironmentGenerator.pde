class EnvironmentGenerator {

    public List<Environment> getEnvironments() {
        List<Environment> environments = new ArrayList<Environment>();
        environments.add(getGrass());
        environments.add(getIce());
        return environments;
    }

    public Environment getGrass() {
        return new Environment(
            color(181, 230, 29),
            color(37, 178, 74),
            color(145, 184, 23)
        );
    }

    public Environment getIce() {
        return new Environment(
            color(107, 250, 241),
            color(31, 184, 174),
            color(140, 250, 243)
        );
    }
}
