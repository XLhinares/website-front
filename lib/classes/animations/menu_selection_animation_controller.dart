// Flutter dependencies
import "package:get/get.dart";

/// A controller for the menu animation.
class MenuSelectionAnimationController extends GetxController {

  // VARIABLES =================================================================

  /// The list of the tile heights in the order in which they come.
  final List<double> _heightOfTiles = [];

  /// The padding between the tiles.
  double _padding = 0;

  /// The index of the selected tile.
  int _selectedTile = -1;

  // GETTERS ===================================================================

  /// The height at which the selected starts
  double get offset {
    double res = 0;
    for (int i = 0 ; i < _selectedTile ; i++) {
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
  MenuSelectionAnimationController();

  // METHODS ===================================================================

  /// Adds the height of one tile to the stack
  void addTileHeight (double height) {

    // printInfo(info: "Adding a tile of height: $height");
    _heightOfTiles.add(height);
    if (_selectedTile < 0) selectTile(0);
  }

  /// Adds a padding between the tiles.
  void setPadding (double height) {
    _padding = height;
  }

  /// Selects a new tile and updates the controller.
  void selectTile (int index) {

    _selectedTile = index;
    printInfo(info: "Going to tile: $index.\n"
        "Offset: $offset ; height: $height");
    update();
  }
}