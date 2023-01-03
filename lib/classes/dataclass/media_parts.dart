import "dataclass.dart";

/// In-app representation of the different parts of a given media.
///
/// Used in the [MediaFocus] widgets.
class MediaParts {
  // VARIABLES =================================================================

  /// The sorted list of entries making the media parts.
  final List<MediaPartEntry> entries;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaParts] matching the given parameters.
  MediaParts(this.entries);

  /// Factory instantiate the [MediaParts] from a json-like map.
  ///
  /// Used when fetching data from the API.
  factory MediaParts.fromJson(List<dynamic> json) {
    final List<MediaPartEntry> entries = [];
    for (final value in json) {
      entries.add(MediaPartEntry.fromJson(value as Map<String, dynamic>));
    }
    entries.sort(
      (a, b) => a.index.compareTo(b.index),
    );
    return MediaParts(entries);
  }
}
