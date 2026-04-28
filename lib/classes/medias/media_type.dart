/// Representation of a "mode" (pretty much the top-level state of the app).
class MediaType {
  // CONSTANTS =================================================================

  /// The unique [MediaType.blog].
  static const MediaType blog = MediaType._internal("blog");

  /// The unique [MediaType.project].
  static const MediaType project = MediaType._internal("project");

  /// The unique [MediaType.other].
  static const MediaType other = MediaType._internal("other");

  /// The different possible values of [MediaType].
  static const values = [
    blog,
    project,
    other,
  ];

  // VARIABLES =================================================================

  /// The name of the mode.
  final String name;

  // CONSTRUCTOR ===============================================================

  const MediaType._internal(this.name);

  /// Returns an [MediaType] instance according to the mode's name.
  factory MediaType.parse(String name) {
    switch (name.toLowerCase()) {
      case "blog":
        return MediaType.blog;
      case "project":
        return MediaType.project;
      default:
        return MediaType.other;
    }
  }
}
