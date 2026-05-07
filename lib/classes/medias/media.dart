import "../../globals.dart";
import "media_type.dart";

/// A dataclass containing the metadata of a media.
class Media {
  // VARIABLES =================================================================

  /// The id of the media in the database.
  final int id;

  /// The name of the media.
  final String title;

  /// The name of the media.
  final String? subtitle;

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

  /// An optional repo hosting this media.
  ///
  /// Usually using github but any website will work.
  final String? github;

  /// An optional website matching this media.
  final String? website;

  /// The status of Xeppelin concerning this project (owner, contributor, reviewer, etc.).
  final String? status;

  // GETTERS ===================================================================

  /// A preview image of the media.
  String get preview =>
      _preview.contains("http") ? _preview : "${app.network.assets}$_preview";

  /// Whether the media has a valid subtitle.
  bool get hasSubtitle => subtitle?.isNotEmpty ?? false;

  /// Whether I own the project related to this media.
  bool get isOwner => (status ?? "owner") == "owner";

  /// Whether the media has a github repo.
  bool get hasGithub => github?.isNotEmpty ?? false;

  /// Whether the media has a website
  bool get hasWebsite => website?.isNotEmpty ?? false;

  // CONSTRUCTOR ===============================================================

  /// Returns a [Media] matching the given parameters.
  const Media({
    required this.id,
    required this.title,
    this.subtitle,
    this.type = MediaType.other,
    this.relevance = 0,
    required this.date,
    List<String>? tags,
    String? previewPath,
    String? summary,
    this.github,
    this.website,
    this.status,
  })  : _preview = previewPath ?? "medias/default.webp",
        tags = tags ?? const [],
        summary = summary ?? "media_no_summary";

  /// Returns a [Media] matching the given json element.
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json["id"],
      title: json["title"] ?? json["name"],
      subtitle: json["subtitle"],
      type: MediaType.parse(json["type"]),
      relevance: double.parse(json["relevance"].toString()),
      date: DateTime.parse(json["date"]),
      tags: json.containsKey("tags")
          ? List<String>.from(json["tags"])
          : <String>[],
      previewPath: json["preview"],
      summary: json["summary"],
      github: json["github"],
      website: json["website"],
      status: json["status"],
    );
  }

  // METHODS ==================================================================

  /// Tries to launch the media's website, if it's provided.
  void launchGithub() async {
    if (!hasGithub) return;
    await app.network.launch(github!);
  }

  /// Tries to launch the media's github repo, if it's provided.
  void launchWebsite() async {
    if (!hasWebsite) return;
    await app.network.launch(website!);
  }
}
