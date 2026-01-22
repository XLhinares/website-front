import "package:get/get.dart";

import "../../utils/tools.dart";
import "app_manager_plugin.dart";
import "plugin_cookies.dart";
import "plugin_network.dart";
import "plugin_medias.dart";
import "plugin_theme.dart";
import "plugin_authentication.dart";

/// The core of the AppManager class.
///
/// It exists to enable the use of mixins.
/// It contains the database so that the mixins are also able to manipulate it.
class AppManager extends GetxController {
  // VARIABLES =================================================================

  /// Whether the database was loaded.
  late final RxBool _loaded = false.obs;

  /// The plugin handling the app themes.
  /// It should be loaded before the cookies.
  late final themes = ThemePlugin();

  /// The plugin handling the cookies.
  late final cookies = CookiePlugin();

  /// The plugin handling the cookies.
  late final network = NetworkPlugin();

  /// The plugin handling the word decks.
  late final medias = MediaPlugin();

  /// The plugin handling device vibrations.
  late final authentication = AuthenticationPlugin();

  /// The list of plugins added to the app manager.
  ///
  /// !WARNING! The order matters if the plugins communicate.
  /// The plugins can be instantiated as a class member (rather than in the
  /// list) to make it easier to manipulate, however be careful to point to
  /// the same instance!
  late final List<AppManagerPlugin> plugins = [
    network,
    themes,
    cookies,
    medias,
    authentication,
  ];

  // GETTERS ===================================================================

  /// Whether the user as a whole is loaded.
  bool get isLoaded => _loaded.value;

  // CONSTRUCTOR ===============================================================

  /// The private instance of user.
  ///
  /// It insures that the class is instantiated only once at the beginning.
  static final AppManager _instance = AppManager._internal();

  /// Re_turns the unique CameraPlugin instance.
  factory AppManager() => _instance;

  /// The real constructor of the class.
  /// It is called exactly once and contains the instantiation logic.
  AppManager._internal() {
    initialize();
  }

  /// Initializing the user.
  ///
  /// It initialize the database and loads the relevant data.
  /// Also initializes workers.
  Future<void> initialize() async => await tryWrapper(
        () async {
          dlog("Loading plugins...");
          if (isLoaded) return;

          for (final plugin in plugins) {
            await plugin.load();
          }
        },
        then: (success) {
          dlog("All plugins loaded!");
          checkIfLoaded();
        },
        errorMessage: "Error while initializing app manager.",
      );

  /// Checks whether all the necessary plugins are loaded and updates.
  void checkIfLoaded() {
    _loaded.value = plugins
        .map<bool>((e) => e.isLoaded.value || !e.blocking)
        .reduce((value, element) => value && element);

    for (final plugin in plugins) {
      dlog(plugin.debugInfo);
    }
    update();
  }

  // METHODS ===================================================================
}
