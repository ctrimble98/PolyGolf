class PreDefCourses {

    PreDefHoles preDefHoles;

    public PreDefCourses() {
        preDefHoles = new PreDefHoles();
    }

    public List<Hole> getBasicCourse() {
        List<Hole> holes = new ArrayList<Hole>();
        holes.add(preDefHoles.getBasic1());
        holes.add(preDefHoles.getBasic2());
        holes.add(preDefHoles.getBasic3());
        holes.add(preDefHoles.getBasic4());
        holes.add(preDefHoles.getBasic5());
        holes.add(preDefHoles.getBasic6());
        holes.add(preDefHoles.getBasic7());
        holes.add(preDefHoles.getBasic8());
        holes.add(preDefHoles.getBasic9());
        return holes;
    }
}
