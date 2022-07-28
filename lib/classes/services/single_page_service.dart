// Package dependencies
import "package:get/get.dart";
import "package:website_front/classes/services/app_mode.dart";


/// A service managing the state of the app.
class SinglePageService extends GetxController {

  // VARIABLES =================================================================

  /// The current mode of the app.
  late AppMode _mode;

  // GETTERS ===================================================================

  /// The current mode of the app.
  AppMode get mode => _mode;

  /// Whether the app is at home.
  bool get atHome => _mode == AppMode.home;

  // CONSTRUCTOR ===============================================================

  /// The private instance of SinglePageService.
  ///
  /// It insures that the class is instantiated only once at the beginning.
  static final SinglePageService _instance = SinglePageService._internal();

  /// Re_turns the unique SinglePageService instance.
  factory SinglePageService() => _instance;

  /// The real constructor of the class.
  ///
  /// It is called exactly once and contains the instantiation logic.
  SinglePageService._internal() {

    // INITIAL VALUES ----------------------------------------------------------

    _mode = AppMode.home;
  }

  // METHODS ===================================================================

  /// Goes to the given mode and reloads the controller.
  void goTo (AppMode mode) {
    _mode = mode;
    update();
  }

}