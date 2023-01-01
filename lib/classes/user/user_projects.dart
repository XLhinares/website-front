import "dart:collection";

import "../../utils/utils.dart";
import "../dataclass/project_metadata.dart";
import "user_core.dart";

/// A mixin that implements the handling of trackables in the user class.
mixin UserProjects on UserCore {
  // VARIABLES =================================================================

  /// A list of the registered projects partial metadata.
  ///
  /// Only the most important information are stored to save place.
  late final List<ProjectMetadata> _projectsPreview;

  /// A list of the registered projects metadata.
  ///
  /// All the information concerning the given project is stored in this variable.
  /// For that reason it should only be filled on demand.
  late final Map<String, ProjectMetadata> _projectsFull;

  // GETTERS ===================================================================

  /// A list of the registered projects partial metadata.
  UnmodifiableListView<ProjectMetadata> get projects =>
      UnmodifiableListView(_projectsPreview);

  // PSEUDO-GETTERS ============================================================

  /// The full metadata of the project matching the given name, if it is known.
  ProjectMetadata? getProject(String name) => _projectsFull[name];

  // CONSTRUCTOR ===============================================================

  /// Instantiates the late fields of the trackable mixin.
  void instantiateProjects() {
    _projectsPreview = [];
    _projectsFull = {};
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
        _projectsPreview.clear();
        _projectsPreview.addAll(projects);

        update();
      });

  /// Loads the list of projects from the API.
  Future<void> loadProject(String name) async => tryWrapper(() async {
        final project = await api.getProject(name);
        if (project == null) return;

        _projectsFull[name] = project;

        update();
      });
}
