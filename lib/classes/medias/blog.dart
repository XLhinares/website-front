import "media.dart";
import "media_type.dart";

/// The in-app representation of a blog.
class Blog extends Media {
  /// Returns an instance of [Blog] matching the given parameters.
  Blog({
    required super.id,
    required super.name,
    required super.date,
    super.relevance,
    List<String>? tags,
    String? previewPath,
    String? summary,
  }) : super(
          type: MediaType.blog,
          tags: tags,
          previewPath: previewPath,
          summary: summary,
        );

  /// Factory instantiate the [Blog] from a json-like map.
  ///
  /// Used when fetching data from the API.
  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
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
