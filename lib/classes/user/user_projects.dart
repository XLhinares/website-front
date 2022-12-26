import "dart:collection";

import "../../utils/utils.dart";
import "../dataclass/project_preview.dart";
import "user_core.dart";

/// A mixin that implements the handling of trackables in the user class.
mixin UserProjects on UserCore {
  // VARIABLES =================================================================

  late final List<ProjectPreview> _projects;

  // GETTERS ===================================================================

  /// A list of the registered trackable metadata.
  UnmodifiableListView<ProjectPreview> get projects =>
      UnmodifiableListView(_projects);

  // CONSTRUCTOR ===============================================================

  /// Instantiates the late fields of the trackable mixin.
  void instantiateProjects() {
    _projects = [];
  }

  /// Initializes the people mixin.
  Future<bool> initializeProjects() => tryWrapper(
        () async {
          // The initialization logic goes here.
          return true;
        },
        errorMessage: "Could not initialize the people mixin.",
      );

  /// All the tasks that should be run after the app was loaded.
  Future<void> postInitProjects() async {
    // We don't load the projects by default because it would slow down the
    // user's device.
    // loadProjects();
  }

  // METHODS ===================================================================

  /// Loads the list of projects from the API.
  Future<void> loadProjects() async => tryWrapper(() async {
        final projects = await api.getProjects();
        _projects.clear();
        _projects.addAll(projects);

        update();
      });
}
