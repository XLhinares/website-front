import "../../utils/globals.dart";

/// A dataclass containing the main properties of a project.
class ProjectMetadata {
  // VARIABLES =================================================================

  /// The id of the project in the database.
  final int id;

  /// The name of the project.
  final String name;

  /// A metric describing how much I want to put this project forward.
  final double relevance;

  /// The date at which the project was started.
  final DateTime? dateStart;

  /// The date at which the project was last worked on.
  final DateTime? dateEnd;

  /// The list of tags associated with this project.
  final List<String> tags;

  /// The path to access a preview image of the project.
  ///
  /// The image should be in 16:9 ratio and webp format.
  final String _preview;

  /// A short description of the project.
  final String summary;

  /// The full description of the project.
  final String description;

  // GETTERS ===================================================================

  /// A preview image of the project.
  String get preview => "${api.assets}$_preview";

  // CONSTRUCTOR ===============================================================

  /// Returns a [ProjectMetadata] matching the given parameters.
  const ProjectMetadata({
    required this.id,
    required this.name,
    this.relevance = 0,
    this.dateStart,
    this.dateEnd,
    List<String>? tags,
    String? previewPath,
    String? summary,
    String? description,
  })  : _preview = previewPath ?? "project/default.webp",
        tags = tags ?? const [],
        summary = summary ?? "No summary given.",
        description = summary ?? "No description given.";

  /// Returns a [ProjectMetadata] matching the given json element.
  factory ProjectMetadata.fromJson(Map<String, dynamic> json) =>
      ProjectMetadata(
        id: json["id"],
        name: json["name"],
        relevance: double.parse(json["relevance"].toString()),
        dateStart: json.containsKey("date_start")
            ? DateTime.fromMillisecondsSinceEpoch(json["date_start"])
            : null,
        dateEnd: json.containsKey("date_end")
            ? DateTime.fromMillisecondsSinceEpoch(json["date_end"])
            : null,
        tags: json.containsKey("tags")
            ? List<String>.from(json["tags"])
            : <String>[],
        previewPath: json["preview"],
        summary: json["summary"],
        description: json["description"],
      );
}
