/// A pseudo-enumeration of the handled types of [MediaParts].
class MediaPartType {
  // CONSTANTS =================================================================

  /// The unique [MediaPartType.text].
  static const MediaPartType text = MediaPartType._internal("text");

  /// The unique [MediaPartType.image].
  static const MediaPartType image = MediaPartType._internal("image");

  /// The unique [MediaPartType.other].
  static const MediaPartType other = MediaPartType._internal("other");

  /// The different possible values of [MediaPartType].
  static const values = [
    text,
    image,
    other,
  ];

  // VARIABLES =================================================================

  /// The name of the mode.
  final String name;

  // CONSTRUCTOR ===============================================================

  const MediaPartType._internal(this.name);

  /// Returns an MediaPartType instance according to the mode's name.
  factory MediaPartType.parse(String name) {
    switch (name.toLowerCase()) {
      case "text":
        return MediaPartType.text;
      case "image":
        return MediaPartType.image;
      default:
        return MediaPartType.other;
    }
  }
}
