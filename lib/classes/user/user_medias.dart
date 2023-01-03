import "dart:collection";

import "../../utils/utils.dart";
import "../dataclass/dataclass.dart";
import "user_core.dart";

/// A mixin that implements the handling of trackables in the user class.
mixin UserMedias on UserCore {
  // VARIABLES =================================================================

  /// A list of the registered projects metadata.
  late final Map<int, Project> _projects;

  /// A list of the registered projects metadata.
  late final Map<int, Blog> _blogs;

  late final Map<int, MediaParts> _mediaParts;

  // GETTERS ===================================================================

  /// A list of the registered projects partial metadata.
  UnmodifiableListView<Project> get projects =>
      UnmodifiableListView(_projects.values);

  // PSEUDO-GETTERS ============================================================

  /// The parts of the media matching the given id, if it is known.
  MediaParts? getParts(int id) => _mediaParts[id];

  /// The project matching the given id, if it is known.
  Project getProject(int id) => _projects[id]!;

  /// The blog matching the given id, if it is known.
  Blog getBlog(int id) => _blogs[id]!;

  // CONSTRUCTOR ===============================================================

  /// Instantiates the late fields of the trackable mixin.
  void instantiateMedias() {
    _projects = {};
    _blogs = {};
    _mediaParts = {};
  }

  /// Initializes the people mixin.
  Future<bool> initializeMedias() => tryWrapper(
        () async {
          // The initialization logic goes here.
          return true;
        },
        errorMessage: "Could not initialize the people mixin.",
      );

  /// All the tasks that should be run after the app was loaded.
  Future<void> postInitMedias() async {
    // We don't load the projects by default because it would slow down the
    // user's device.
    // loadMedias();
  }

  // METHODS ===================================================================

  /// Loads the list of projects from the API.
  Future<void> loadMedias(MediaType type) async => tryWrapper(() async {
        final res = await api.getMedias(type: type);

        if (type == MediaType.project) {
          _projects.clear();
          for (final element in res) {
            _projects[element.id] = element as Project;
          }
        } else if (type == MediaType.blog) {
          _blogs.clear();
          for (final element in res) {
            _blogs[element.id] = element as Blog;
          }
        }

        update();
      });

  /// Loads the list of projects from the API.
  Future<void> loadMediaParts(int id) async => tryWrapper(() async {
        final res = await api.getMediaParts(id);
        if (res == null) return;
        _mediaParts[id] = res;

        update();
      });
}
