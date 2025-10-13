/// An enumeration of the different sorting option on
enum APISorter {
  /// Sorting by order of relevance.
  ///
  /// Relevance is computer server-side; but we can overall assume that it's
  /// directly correlated with how much I believe the project showcases my
  /// skills.
  relevance,

  /// Sorting by chronological order of last worked on.
  date,
}

/// A set of utilities simplifying the building of customs URLs.
class CustomURL {
  // VARIABLES =================================================================

  late final StringBuffer _buffer;

  // GETTERS ===================================================================

  /// Removes extra artifacts from the URL.
  ///
  /// The goal is to be able to combine the other methods without having to
  /// worry about cleaning leftover artifacts (like extra ",").
  String get clean {
    var res = _buffer.toString();

    // Remove double artifacts.
    res = res.replaceAll("/&", "/");
    res = res.replaceAll("?&", "?");
    res = res.replaceAll(",&", "&");

    // Remove trailing characters.
    if (res[res.length - 1] == ",") return res.substring(0, res.length - 1);
    if (res[res.length - 1] == "?") return res.substring(0, res.length - 1);
    return res;
  }

  /// The URL as a dart [URI] object.
  Uri get cleanUri => Uri.parse(clean);

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [CustomWhere] matching the given parameters.
  CustomURL({
    String? initialText,
  }) {
    _buffer = StringBuffer(initialText ?? "");
  }

  // METHODS ===================================================================

  /// Auto-completes the URL with the given path.
  ///
  /// If the path is [null], a lone "/" is added.
  void addPath(
    Object? path,
  ) {
    if (path != null) _buffer.write(path.toString());
    _buffer.write("/");
  }

  /// Auto-completes the URL with the given file.
  ///
  /// If the path is [null], does nothing.
  void addFile(
    Object? file,
  ) {
    if (file == null) return;
    _buffer.write("${file.toString()}?");
  }

  /// Auto-completes the URL with the a custom parameter and value.
  ///
  /// If either is null, then nothing is added to the URL.
  void addCustomParameter([
    String? name,
    Object? value,
  ]) {
    if (name == null || value == null) return;
    _buffer.write("&$name=");
    _buffer.write(value.toString());
  }

  /// Auto-completes the URL with the given query.
  void addQueryParameter(
    String? text,
  ) =>
      addCustomParameter("query", text);

  /// Auto-completes the URL with the given sorter.
  void addSorterParameter(
    APISorter? sorter,
  ) =>
      addCustomParameter("sorter", sorter.toString());
}
