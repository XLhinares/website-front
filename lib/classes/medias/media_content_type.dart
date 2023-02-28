/// A pseudo-enumeration of the handled types of [MediaParts].
class MediaContentType {
  // CONSTANTS =================================================================

  /// The unique [MediaContentType.text].
  static const MediaContentType text = MediaContentType._internal("text");

  /// The unique [MediaContentType.image].
  static const MediaContentType image = MediaContentType._internal("image");

  /// The unique [MediaContentType.other].
  static const MediaContentType other = MediaContentType._internal("other");

  /// The different possible values of [MediaContentType].
  static const values = [
    text,
    image,
    other,
  ];

  // VARIABLES =================================================================

  /// The name of the mode.
  final String name;

  // CONSTRUCTOR ===============================================================

  const MediaContentType._internal(this.name);

  /// Returns an MediaPartType instance according to the mode's name.
  factory MediaContentType.parse(String name) {
    switch (name.toLowerCase()) {
      case "text":
        return MediaContentType.text;
      case "image":
        return MediaContentType.image;
      default:
        return MediaContentType.other;
    }
  }
}
