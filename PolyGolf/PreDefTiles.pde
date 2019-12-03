class PreDefTiles {

    Tile basicStart;
    Tile basicEnd;
    Tile emptyVerticalCorridor;

    public PreDefTiles() {
        basicStart = new Tile(new boolean[]{true, true, false, true}, new ArrayList<Polygon>());
        basicEnd = new Tile(new boolean[]{false, true, true, true}, new ArrayList<Polygon>());
        emptyVerticalCorridor = new Tile(new boolean[]{false, true, false, true}, new ArrayList<Polygon>());
    }
}
