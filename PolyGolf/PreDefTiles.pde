class PreDefTiles {

    final Tile basicStart = new Tile(new boolean[]{true, true, false, true}, new ArrayList<Polygon>());
    final Tile basicEnd = new Tile(new boolean[]{false, true, true, true}, new ArrayList<Polygon>());
    final Tile emptyVerticalCorridor = new Tile(new boolean[]{false, true, false, true}, new ArrayList<Polygon>());
}
