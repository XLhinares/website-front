import "package:get/get.dart";

/// A controller for the menu animation.
class MenuSelectionAnimationController extends GetxController {
  // VARIABLES =================================================================

  /// The list of the tile heights in the order in which they come.
  late final List<double> _heightOfTiles;

  /// The padding between the tiles.
  double _padding = 0;

  /// The index of the selected tile.
  int _selectedTile = 0;

  // GETTERS ===================================================================

  /// The height at which the selected starts
  double get offset {
    double res = 0;
    for (int i = 0; i < _selectedTile; i++) {
      res += _heightOfTiles[i] + _padding;
    }
    return res;
  }

  /// the height of the current selected tile.
  double get height {
    // If no tile is selected, 0 is returned.
    if (_selectedTile < 0) return 0;

    return _heightOfTiles[_selectedTile];
  }

  // CONSTRUCTOR ===============================================================

  /// Returns an [MenuSelectionAnimationController].
  MenuSelectionAnimationController({required int length}) {
    _heightOfTiles = List<double>.generate(length, (index) => 0);
  }

  // METHODS ===================================================================

  /// Adds the height of one tile to the stack
  void setTileHeight(int index, double height) {
    assert(index >= 0 && index < _heightOfTiles.length,
        "[index] should be between 0 and ${_heightOfTiles.length}");

    _heightOfTiles[index] = height;
  }

  /// Adds a padding between the tiles.
  void setPadding(double height) {
    _padding = height;
  }

  /// Selects a new tile and updates the controller.
  void selectTile(int index) {
    _selectedTile = index;
    update();
  }
}
