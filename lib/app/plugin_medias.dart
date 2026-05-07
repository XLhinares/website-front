import "dart:async";

import "../classes/medias/media.dart";
import "../classes/medias/media_content.dart";
import "../classes/medias/media_type.dart";
import "../globals.dart";
import "../utils/tools.dart";
import "app_manager_plugin.dart";

/// A plugin that handles loading and storing the medias.
class MediaPlugin extends AppManagerPlugin {
  @override
  bool get blocking => true;
// VARIABLES =================================================================

  /// A list of the registered projects metadata.
  late final Map<int, Media> _all;

  late final Map<int, MediaContent> _mediaContent;

  // GETTERS ===================================================================

  /// A list of the registered projects.
  List<Media> get projects =>
      _all.values.where((e) => e.type == MediaType.project).toList();

  /// A list of the registered blogs.
  List<Media> get blogs =>
      _all.values.where((e) => e.type == MediaType.blog).toList();

  /// A list of the registered persons.
  List<Media> get persons =>
      _all.values.where((e) => e.type == MediaType.person).toList();

  /// A list of the persons who recommend me.
  List<Media> get recommenders => _all.values
      .where((e) => e.type == MediaType.person && e.status == "recommender")
      .toList();

  /// A list of the persons who recommend me.
  List<Media> get recommendeds => _all.values
      .where((e) => e.type == MediaType.person && e.status == "recommended")
      .toList();
  // PSEUDO-GETTERS ============================================================

  /// Whether the user has the parts of the media matching the given id.
  bool hasContent(int id) => _mediaContent.containsKey(id);

  /// The parts of the media matching the given id, if it is known.
  MediaContent? getContent(int id) => _mediaContent[id];

  /// The project matching the given id, if it is known.
  Media fetchByID(int id) => _all[id]!;

  // CONSTRUCTOR ===============================================================

  @override
  Future<void> load({SuccessCallback? then}) async {
    _all = {};
    _mediaContent = {};

    // Asynchronously load the medias.
    reloadProjects();
    reloadPersons();

    return super.load(then: then);
  }

  // METHODS ===================================================================

  /// Loads and return the list of projects from the API.
  ///
  /// The list of known media is also updated with these projects.
  /// Upon completion, this [MediaPlugin] instance is reloaded.
  Future<List<Media>> reloadProjects() async => tryWrapper(() async {
        final res = await app.network.getMedias(type: MediaType.project);
        _all.removeWhere((k, v) => v.type == MediaType.project);
        _all.addEntries(res.map((e) => MapEntry(e.id, e)));
        update();
        return res;
      });

  /// Loads and return the list of persons from the API.
  ///
  /// The list of known media is also updated with these persons.
  /// Upon completion, this [MediaPlugin] instance is reloaded.
  Future<List<Media>> reloadPersons() async => tryWrapper(() async {
        final res = await app.network.getMedias(type: MediaType.person);
        _all.removeWhere((k, v) => v.type == MediaType.person);
        _all.addEntries(res.map((e) => MapEntry(e.id, e)));
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
