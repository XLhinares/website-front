import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";

/// A simple type for callback-style functions.
typedef SuccessCallback = void Function(bool success);

/// A general wrapper for future function that handles tries and catches.
Future<T> tryWrapper<T>(
  Future<T> Function() function, {
  String? errorMessage,
  bool rethrowException = true,
  void Function(bool success)? then,
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
    if (rethrowException) {
      rethrow;
    } else {
      res = null as T;
    }
  } finally {
    then?.call(success);
  }
  return res;
}

/// A extension on all objects to give them an easy logging method.
extension DebugLog on Object {
  /// Use [Get.log] to log and display information.
  void dlog(String text, {bool isError = false}) {
    Get.log("[$runtimeType] $text", isError: isError);
  }
}

// DATES ----------------------------------------------------------------------

/// A variable to help format and parse dates.
final DateFormat dateFormatter = DateFormat("dd/mm/yy");

/// List of months abbreviations.
const List<String> months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];

/// List of week days abbreviations.
const List<String> weekdays = ["M", "T", "W", "T", "F", "S", "S"];

/// An extension to help print dates legibly.
extension LegibleDates on DateTime {
  /// The date as a legible string (ex: Dec. 8, 22).
  ///
  /// It isn't possible to parse it back easily to a datetime; therefore it is not
  /// suitable for use in TextFields and the likes.
  String get legible {
    return "${months[month - 1]}. $day, ${year % 100}";
  }

  /// The date as a short string (ex: Jun. 12).
  ///
  /// It isn't possible to parse it back easily to a datetime; therefore it is not
  /// suitable for use in TextFields and the likes.
  String get legibleShort {
    return "${months[month - 1]}. $day";
  }

  /// A compact legible string for the date.
  String get compact {
    return "${day.toString().padLeft(2, "0")}/${month.toString().padLeft(2, "0")}/${(year % 100).toString().padLeft(2, "0")}";
  }

  /// A compact legible string for dates.
  String get yyyymmdd {
    return "${(year % 100).toString().padLeft(2, "0")}${month.toString().padLeft(2, "0")}${day.toString().padLeft(2, "0")}";
  }

  /// A legible [String] to display the month and year.
  String get legibleMY {
    final String legibleMonth = "month_$month".tr;
    return "$legibleMonth $year";
  }
}

// COLORS ----------------------------------------------------------------------

/// A function to help parse Colors given as hex strings.
Color hexColorParser(String hex) =>
    Color(int.parse(hex.substring(1, 7), radix: 16) + 0xFF000000);

/// An extension on [BuildContext] to access the theme's color scheme more conveniently.
extension ContextColor on BuildContext {
  /// Shortcut for [context.theme.colorScheme].
  ColorScheme get colors => theme.colorScheme;

  /// Return the [bodyMedium] text style with the color set to [onSurface]
  TextStyle get bodyMediumOnSurface =>
      textTheme.bodyMedium!.copyWith(color: colors.onSurface);

  /// Return the [bodyMedium] text style with the color set to [onSecondary]
  TextStyle get bodyMediumOnSecondary =>
      textTheme.bodyMedium!.copyWith(color: colors.onSecondary);

  /// Return the [titleMedium] text style with the color set to [onSurface]
  TextStyle get titleMediumOnSurface =>
      textTheme.titleMedium!.copyWith(color: colors.onSurface);

  /// Return the [titleMedium] text style with the color set to [onSecondary]
  TextStyle get titleMediumOnSecondary =>
      textTheme.titleMedium!.copyWith(color: colors.onSecondary);
}

/// A small helper function that returns a human legible duration string, from a number of seconds.
String intToMinSec(int duration) {
  final min = duration ~/ 60;
  final sec = duration % 60;

  return min == 0 ? "${sec}s" : "${min}m ${sec}s";
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
