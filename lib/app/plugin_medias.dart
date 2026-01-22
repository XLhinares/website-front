import "dart:collection";

import "../classes/medias/blog.dart";
import "../classes/medias/media.dart";
import "../classes/medias/media_content.dart";
import "../classes/medias/media_type.dart";
import "../classes/medias/project.dart";
import "../globals.dart";
import "../utils/tools.dart";
import "../utils/tools_api.dart";
import "app_manager_plugin.dart";

/// A plugin that handles the word decks.
class MediaPlugin extends AppManagerPlugin {
  @override
  bool get blocking => true;
// VARIABLES =================================================================

  /// A list of the registered projects metadata.
  late final Map<int, Project> _projects;

  /// A list of the registered projects metadata.
  late final Map<int, Blog> _blogs;

  late final Map<int, MediaContent> _mediaContent;

  // GETTERS ===================================================================

  /// A list of the registered projects partial metadata.
  UnmodifiableListView<Project> get projects =>
      UnmodifiableListView(_projects.values);

  /// A list of the registered blogs partial metadata.
  UnmodifiableListView<Blog> get blogs => UnmodifiableListView(_blogs.values);

  // PSEUDO-GETTERS ============================================================

  /// Whether the user has the parts of the media matching the given id.
  bool hasContent(int id) => _mediaContent.containsKey(id);

  /// The parts of the media matching the given id, if it is known.
  MediaContent? getContent(int id) => _mediaContent[id];

  /// The project matching the given id, if it is known.
  Project getProject(int id) => _projects[id]!;

  /// The blog matching the given id, if it is known.
  Blog getBlog(int id) => _blogs[id]!;

  // CONSTRUCTOR ===============================================================

  @override
  Future<void> load({SuccessCallback? then}) async {
    _projects = {};
    _blogs = {};
    _mediaContent = {};

    return super.load(then: then);
  }

  // METHODS ===================================================================

  /// Loads the list of projects from the API.
  Future<List<T>> loadMedias<T extends Media>({
    APISorter sorter = APISorter.relevance,
    int page = 0,
  }) async =>
      tryWrapper(() async {
        final res = await app.network.getMedias<T>(
          sorter: sorter,
          page: page,
        );

        final type = MediaType.fromType(T);

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
        return res;
      });

  /// Loads the list of projects from the API.
  Future<void> loadMediaContent(int id) async => tryWrapper(() async {
        final res = await app.network.getMediaContent(id);
        if (res != null) _mediaContent[id] = res;
        update();
      });
}
