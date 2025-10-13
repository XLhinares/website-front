import "media.dart";
import "media_type.dart";

/// The in-app representation of a project.
class Project extends Media {
  /// Returns an instance of [Project] matching the given parameters.
  Project({
    required super.id,
    required super.name,
    required super.date,
    super.relevance,
    super.tags,
    super.previewPath,
    super.summary,
  }) : super(
          type: MediaType.project,
        );

  /// Factory instantiate the [Blog] from a json-like map.
  ///
  /// Used when fetching data from the API.
  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"],
        relevance: double.parse(json["relevance"].toString()),
        date: DateTime.parse(json["date"]),
        tags: json.containsKey("tags")
            ? List<String>.from(json["tags"])
            : <String>[],
        previewPath: json["preview"],
        summary: json["summary"],
      );
}
