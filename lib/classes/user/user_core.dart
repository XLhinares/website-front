import "package:flutter/foundation.dart";
import "package:get/get.dart";

import "../../utils/tools.dart";

/// The core of the user class.
///
/// It exists to enable the use of mixins.
abstract class UserCore extends GetxController {
  // VARIABLES =================================================================

  /// Whether the database was loaded.
  late final RxBool _loaded;

  // GETTERS ===================================================================

  /// Whether the user as a whole is loaded.
  bool get loaded => _loaded.value;

  // SETTERS ===================================================================

  /// Sets the value of the loaded field.
  @protected
  set loaded(bool value) => _loaded.value = value;

  // CONSTRUCTOR ===============================================================

  /// Sets up the [UserCore] instance.
  ///
  /// It is not a constructor due to limitations of instances.
  ///
  /// It takes 3 arguments:
  /// * [instantiate] is synchronously run at the beginning.
  /// * [initializes] is the asynchronous logic run afterwards.
  /// * [then] is run after the two others and [loaded] has been set to true.
  void init({
    required void Function() instantiate,
    required Future<void> Function() initialize,
    void Function(bool)? then,
  }) {
    instantiate();
    _asyncInit(
      requires: initialize,
      then: (success) {
        _loaded.value = success;
        then?.call(success);
        update();
      },
    );
  }

  /// Initializing the user.
  ///
  /// It initialize the database and loads the relevant data.
  /// Also initializes workers.
  Future<void> _asyncInit({
    Future<void> Function()? requires,
    void Function(bool)? then,
  }) async =>
      await tryWrapper(
        () async {
          _loaded = false.obs;
          if (loaded) return;

          await requires?.call();

          printInfo(info: "All done!");
        },
        errorMessage:
            "An error occurred while trying to instantiate the database.",
        then: then,
      );

// METHODS ===================================================================

// As this class is meant to be used with mixins, some interface methods might
// need to be abstractly declared, this is the goal of this section.
}
