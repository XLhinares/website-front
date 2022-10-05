import "package:flutter/foundation.dart";

/// A general wrapper for future function that handles tries and catches.
Future<T> tryWrapper<T>(Future<T> Function() function, {
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