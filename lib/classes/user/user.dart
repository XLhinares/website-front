import "dart:async";

import "user_projects.dart";
import "user_core.dart";

/// A singleton class to represent the user.
///
/// The user manages the local database and .
class User extends UserCore with UserProjects {
  // CONSTRUCTOR ===============================================================

  /// The private instance of user.
  ///
  /// It insures that the class is instantiated only once at the beginning.
  static final User _instance = User._internal();

  /// Re_turns the unique User instance.
  factory User() => _instance;

  /// The real constructor of the class.
  ///
  /// It is called exactly once and contains the instantiation logic.
  User._internal() {
    init(
      instantiate: () {
        instantiateProjects();
      },
      initialize: () async {
        await initializeProjects();
      },
    );
  }

  /// All the tasks that should be run after the app was loaded.
  Future<void> postInit() async {
    postInitProjects();
  }

  // DANGER ====================================================================

  /// Drops all the tables and recreates them.
  Future<void> resetDatabase({bool debug = false}) async {
    loaded = false;

    // Delete the new activity
    await initializeProjects();
    loaded = true;

    update();
  }
}
