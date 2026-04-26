import "media_entry.dart";

/// In-app representation of the different parts of a given media.
///
/// Used in the [MediaFocus] widgets.
class MediaContent {
  // VARIABLES =================================================================

  /// The sorted list of entries making the media parts.
  final List<MediaEntry> entries;

  // GETTERS ===================================================================

  /// Whether there are no entries in this object.
  bool get isEmpty => entries.isEmpty;

  /// Whether there are entries in this object.
  bool get isNotEmpty => entries.isNotEmpty;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaContent] matching the given parameters.
  MediaContent(this.entries);

  /// Factory instantiate the [MediaContent] from a json-like map.
  ///
  /// Used when fetching data from the API.
  factory MediaContent.fromJson(List<dynamic> json) {
    final List<MediaEntry> entries = [];
    for (final value in json) {
      entries.add(MediaEntry.fromJson(value as Map<String, dynamic>));
    }
    entries.sort(
      (a, b) => a.index.compareTo(b.index),
    );
    return MediaContent(entries);
  }
}
