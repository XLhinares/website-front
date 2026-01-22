import "package:get/get.dart";

import "../utils/tools.dart";

/// A plugin for the app manager.
///
/// Plugins need to be loaded for the app to start
abstract class AppManagerPlugin extends GetxController {
  // VARIABLES ================================================================

  /// Whether the plugin has finishing initializing and is ready to use.
  final RxBool isLoaded = false.obs;

  /// Wether the app should wait for this plugin to be loaded to start.
  final bool blocking = false;

  // METHODS ==================================================================

  /// Does the logic necessary to load the plugin.
  ///
  /// It's possible to run a function after the loading complete through [then]
  Future<void> load({SuccessCallback? then}) async => tryWrapper(
        () async {
          // The loading logic goes here.
        },
        then: (success) {
          isLoaded.value = true;
          update();
          then?.call(success);
        },
      );

  /// A few information on the status of the plugin.
  String get debugInfo =>
      "[$runtimeType]: ${isLoaded.value ? "Loaded" : "NOT Loaded"}";
}
