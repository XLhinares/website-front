import "dart:convert";
import "dart:io";

import "package:get/get.dart";

import "tools.dart";

/// An extension of [GetConnect] adding a function to fetch json resources online.
extension GetConnectWithJson on GetConnect {
  /// Fetches a JSON object from the given URL.
  ///
  /// Parameters:
  /// * url: The path to the resource; cannot be null.
  /// * dataSubset: a function taking the raw data and returning a subset known
  /// to match the [List<Map<String, dynamic>>] type.
  Future<List<Map<String, dynamic>>> fetchJson(
      String? url, {
        dynamic Function(dynamic)? subsetPicker,
      }) async =>
      tryWrapper<List<Map<String, dynamic>>>(
            () async {
          assert(url != null, "URL cannot be [null].");

          printInfo(info: "Fetching JSON resource from: '$url'");
          final Response response = await get(url!);

          if (response.statusCode == null) {
            throw const HttpException("Response has no status code.");
          }
          if (response.statusCode! < 200 || response.statusCode! >= 400) {
            throw HttpException(
                "Response status code is ${response.statusCode}");
          }

          final data = await json.decode(response.bodyString ?? "");
          final List<Map<String, dynamic>> parsedResponse =
          List<Map<String, dynamic>>.from(subsetPicker?.call(data) ?? data);

          return parsedResponse;
        },
        errorMessage: "Fetching the JSON object from [$url] failed.",
      );
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
  String? get clean {
    var res = _buffer.toString();
    if (res.isEmpty) return null;

    // Remove double artifacts.
    res = res.replaceAll("/&", "/");
    res = res.replaceAll("?&", "?");
    res = res.replaceAll(",&", "&");

    // Remove trailing characters.
    if (res[res.length - 1] == ",") return res.substring(0, res.length - 1);
    if (res[res.length - 1] == "?") return res.substring(0, res.length - 1);
    return res;
  }

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
  void addCustomParameter({
  String? name,
    Object? value,
}) {
    if (name == null || value == null) return;
    _buffer.write("&$name=");
    _buffer.write(value.toString());

  }

  /// Auto-completes the URL with the given query.
  void addQueryParameter(String? text,)
  => addCustomParameter(name: "query", value: text);
}