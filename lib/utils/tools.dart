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
    final String legibleMonth = "month-$month".tr;
    return "$legibleMonth $year";
  }
}
