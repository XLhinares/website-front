import "../../globals.dart";
import "blog.dart";
import "media_type.dart";
import "project.dart";

/// A dataclass containing the metadata of a media.
class Media {
  // VARIABLES =================================================================

  /// The id of the media in the database.
  final int id;

  /// The name of the media.
  final String name;

  /// A metric describing how much I want to put this media forward.
  final double relevance;

  /// The type of this media.
  final MediaType type;

  /// The date at which the media was started.
  final DateTime date;

  /// The list of tags associated with this media.
  final List<String> tags;

  /// The path to access a preview image of the media.
  ///
  /// The image should be in 16:9 ratio and webp format.
  final String _preview;

  /// A short description of the media.
  final String summary;

  /// An optional website matching this media.
  final String? website;

  // GETTERS ===================================================================

  /// A preview image of the media.
  String get preview => "${app.network.assets}$_preview";

  /// Whether the media doesn't have a website (or has an empty website)
  bool get hasNoWebsite => website?.isEmpty ?? true;

  // CONSTRUCTOR ===============================================================

  /// Returns a [Media] matching the given parameters.
  const Media({
    required this.id,
    required this.name,
    this.type = MediaType.other,
    this.relevance = 0,
    required this.date,
    List<String>? tags,
    String? previewPath,
    String? summary,
    this.website,
  })  : _preview = previewPath ?? "medias/default.webp",
        tags = tags ?? const [],
        summary = summary ?? "media_no_summary";

  /// Returns a [Media] matching the given json element.
  factory Media.fromJson(Map<String, dynamic> json) {
    final MediaType type = MediaType.parse(json["type"]);
    switch (type) {
      case MediaType.project:
        return Project.fromJson(json);
      case MediaType.blog:
        return Blog.fromJson(json);

      default:
        return Media(
          id: json["id"],
          name: json["name"],
          type: type,
          relevance: double.parse(json["relevance"].toString()),
          date: DateTime.parse(json["date"]),
          tags: json.containsKey("tags")
              ? List<String>.from(json["tags"])
              : <String>[],
          previewPath: json["preview"],
          summary: json["summary"],
          website: json["website"],
        );
    }
  }

  // METHODS ==================================================================

  /// Tries to launch the media's website, if it's provided.
  void launchWebsite() async {
    if (hasNoWebsite) return;
    await app.network.launch(website!);
  }
}
