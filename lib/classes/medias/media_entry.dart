import "media_content_type.dart";

/// A single entry from a [MediaContent] object.
///
/// It can represent a block of text or an image for instance.
/// It also has an index to order it with other [MediaEntry].
class MediaEntry {
  // VARIABLES =================================================================

  /// An index allowing this [MediaEntry] to be sorted.
  final int index;

  /// The type of the entry.
  ///
  /// It can be a text block or an image for instance.
  final MediaContentType type;

  /// The actual content of the entry.
  final String content;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaEntry] matching the given parameters.
  MediaEntry({
    required this.index,
    required this.type,
    required this.content,
  });

  /// Factory instantiate the [MediaContent] from a json-like map.
  ///
  /// Used when fetching data from the API.
  factory MediaEntry.fromJson(Map<String, dynamic> json) => MediaEntry(
      index: json["entry"],
      type: MediaContentType.parse(json["type"]),
      content: json["content"]);
}
