import "package:flutter/foundation.dart";
import "package:get/get.dart";

/// A general wrapper for future function that handles tries and catches.
Future<T> tryWrapper<T>(
  Future<T> Function() function, {
  String? errorMessage,
  void Function(bool)? then,
}) async {
  T res;
  bool success = false;

  try {
    // Execute the main function
    res = await function();
    success = true;
  } catch (e) {
    success = false;
    if (kDebugMode) {
      print(errorMessage ?? "Unknown error.");
    }
    rethrow;
  } finally {
    then?.call(success);
  }

  return res;
}

/// An extension on [DateTime] to display user-friendly dates.
extension DateLegible on DateTime {
  /// A legible [String] to display the month and year.
  String get legibleMY {
    final String legibleMonth = "month_$month".tr;
    return "$legibleMonth $year";
  }
}

/// An extension on [String] to automatically fill in some frequently used information.
extension XeppelinMD on String {
  /// The string with some website-specific modifications.
  ///
  /// The list of modifications is:
  /// - "$xeppelinMD" => "[xeppelin.org](www.xeppelin.org)"
  /// - "$xeppelinURL" => "www.xeppelin.org"
  String get withXeppelinMD {
    final String result = replaceAllMapped(
        "\$xeppelinMD", (match) => "[xeppelin.org](www.xeppelin.org)")
      ..replaceAllMapped("\$xeppelinURL", (match) => "www.xeppelin.org");

    return result;
  }
}
