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

/// Prints the given text with ANSI color highlights.
///
/// !WARNING!
/// Don't use it in regular code and use [Object.dlog] instead.
/// This is meant to be used in the git config only!
void colorLog(String text, {bool isError = false}) {
  // This forces GetX logs into the standard print stream
  if (!kDebugMode) return;

  const String reset = "\x1b[0m";
  const String white = "\x1b[37m";
  const String red = "\x1b[31m";
  const String green = "\x1b[32m";
  const String grey = "\x1b[90m";
  const String yellow = "\x1b[33m";

  final String coloredText = text
      .replaceAll("[", "$yellow[") // Yellow for subsequent [
      .replaceAll("] $yellow[", "] $grey[") // Yellow for subsequent [
      .replaceFirstMapped(
        RegExp(r"^\x1b\[33m\["),
        (m) => "$grey[",
      ) // Grey for first [
      .replaceAll("]", "]$white"); // Reset

  if (isError) {
    // ignore: avoid_print
    print("$red[E]$white $coloredText$reset");
  } else {
    // ignore: avoid_print
    print("$green[D]$white $coloredText$reset");
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

/// A small helper function that returns a human legible duration string, from a number of seconds.
String intToMinSec(int duration) {
  final min = duration ~/ 60;
  final sec = duration % 60;

  return min == 0 ? "${sec}s" : "${min}m ${sec}s";
}
