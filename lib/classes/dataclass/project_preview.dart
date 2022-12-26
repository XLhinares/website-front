import "../../utils/globals.dart";

/// A dataclass
class ProjectPreview {
  // VARIABLES =================================================================

  /// The name of the project.
  final String name;

  /// The path to access a preview image of the project.
  ///
  /// The image should be in 16:9 ratio and webp format.
  final String _preview;

  /// A short description of the project.
  final String summary;

  // GETTERS ===================================================================

  /// A preview image of the project.
  String get preview => "${api.assets}$_preview";

  // CONSTRUCTOR ===============================================================

  /// Returns a [ProjectPreview] matching the given parameters.
  const ProjectPreview({
    required this.name,
    required String previewPath,
    required this.summary,
  }) : _preview = previewPath;

  /// Returns a [ProjectPreview] matching the given json element.
  factory ProjectPreview.fromJson(Map<String, dynamic> json) => ProjectPreview(
        name: json["name"],
        previewPath: json["preview"],
        summary: json["summary"],
      );
}
