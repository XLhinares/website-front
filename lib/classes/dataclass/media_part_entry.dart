import "dataclass.dart";

/// A single entry from a [MediaParts] object.
///
/// It can represent a block of text or an image for instance.
/// It also has an index to order it with other [MediaPartEntry].
class MediaPartEntry {
  // VARIABLES =================================================================

  /// An index allowing this [MediaPartEntry] to be sorted.
  final int index;

  /// The type of the entry.
  ///
  /// It can be a text block or an image for instance.
  final MediaPartType type;

  /// The actual content of the entry.
  final String content;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaPartEntry] matching the given parameters.
  MediaPartEntry({
    required this.index,
    required this.type,
    required this.content,
  });

  /// Factory instantiate the [MediaParts] from a json-like map.
  ///
  /// Used when fetching data from the API.
  factory MediaPartEntry.fromJson(Map<String, dynamic> json) => MediaPartEntry(
      index: json["entry"],
      type: MediaPartType.parse(json["type"]),
      content: json["content"]);
}
