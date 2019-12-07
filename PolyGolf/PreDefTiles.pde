class PreDefTiles {

    public Tile getBasicStart() {
        return new Tile(new boolean[]{true, true, false, true}, new ArrayList<Polygon>());
    }

    public Tile getBasicEnd() {
        return new Tile(new boolean[]{false, true, true, true}, new ArrayList<Polygon>());
    }

    public Tile getEmptyVerticalCorridor() {
        return new Tile(new boolean[]{false, true, false, true}, new ArrayList<Polygon>());
    }
}
