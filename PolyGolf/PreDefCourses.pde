class PreDefCourses {

    PreDefHoles preDefHoles;

    public PreDefCourses() {
        preDefHoles = new PreDefHoles();
    }

    public List<Hole> getBasicCourse() {
        List<Hole> holes = new ArrayList<Hole>();
        holes.add(preDefHoles.getBasic1());
        return holes;
    }
}
