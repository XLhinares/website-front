import "dart:math";

import "package:flutter/material.dart";
import "package:get/get.dart";

import "tools.dart";

// DEBUG =======================================================================

/// A extension on all objects to give them an easy logging method.
extension DebugLog on Object {
  /// Use [Get.log] to log and display information.
  void dlog(String text, {bool isError = false}) {
    colorLog("[$runtimeType] $text", isError: isError);
  }
}

// BUILDCONTEXT ================================================================

/// An extension on [BuildContext] to access the theme's color scheme more conveniently.
///
/// It also adds some text styles that rely on colors.
extension ContextColor on BuildContext {
  /// Shortcut for [context.theme.colorScheme].
  ColorScheme get colors => theme.colorScheme;

  /// Return the [bodySmall] text style with the color set to [onSurface]
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

  /// Return the [labelMedium] text style with the color set to [onSurface]
  TextStyle get labelMediumOnSurface =>
      textTheme.labelMedium!.copyWith(color: colors.onSurface);

  /// Return the [labelMedium] text style with the color set to [onSecondary]
  TextStyle get labelMediumOnSecondary =>
      textTheme.labelMedium!.copyWith(color: colors.onSecondary);

  /// Return the [labelSmall] text style with the color set to [onSurface]
  TextStyle get labelSmallOnSurface =>
      textTheme.labelSmall!.copyWith(color: colors.onSurface);

  /// Return the [labelSmall] text style with the color set to [onSecondary]
  TextStyle get labelSmallOnSecondary =>
      textTheme.labelSmall!.copyWith(color: colors.onSecondary);

  /// Return the [labelSmall] text style with the color set to [error]
  TextStyle get labelError =>
      textTheme.labelSmall!.copyWith(color: colors.error);
}

// TEXTSTYLE ===================================================================

/// An extension on [TextStyle] to add the following features:
/// - copy with alpha.
extension ExtTextStyle on TextStyle {
  /// Returns a copy of this [TextStyle] with the given color transparency.
  ///
  /// Doesn't work if the color is not set.
  TextStyle withAlpha(int alpha) => copyWith(color: color?.withAlpha(alpha));

  /// This text style but slighlty transparents.
  ///
  /// Used for text hints.
  TextStyle get asHint => withAlpha(150);
}

/// An extension on [Color] to add the following features:
/// - standardized [asHint] transparency.
extension ExtColor on Color {
  /// This color but slightly transparent.
  ///
  /// Used to uniformize dimming throughout the app.
  Color get asHint => withAlpha(150);
}

// DATETIME ====================================================================

/// An extension to help print dates legibly.
extension DateTimeUtils on DateTime {
  /// Returns a new object at the same date but without the time components.
  DateTime asDate() => DateTime(year, month, day);

  /// The [DateTime] object for today at midnight (in the current timezone).
  static DateTime today() => DateTime.now().asDate();

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

  /// The date as a short string (ex: Jun. 12) on two lines.
  ///
  /// It isn't possible to parse it back easily to a datetime; therefore it is not
  /// suitable for use in TextFields and the likes.
  String get legibleShortSplit {
    return "${month.toString().padLeft(2, "0")}\n${day.toString().padLeft(2, "0")}";
  }

  /// A compact legible string for the date.
  String get compact {
    return "${day.toString().padLeft(2, "0")}/${month.toString().padLeft(2, "0")}/${(year % 100).toString().padLeft(2, "0")}";
  }

  /// A compact legible string for dates.
  String get yyyymmdd {
    return "${(year % 100).toString().padLeft(2, "0")}${month.toString().padLeft(2, "0")}${day.toString().padLeft(2, "0")}";
  }
}

// STRING ======================================================================

/// An extension on [String] to give them some extra convenience methods.
extension ExtString on String {
  /// Returns a substring starting at the beginning of the string and of length
  /// [maxLength] (unless the original string is shorter, in which case it is
  /// returned in full)
  String excerpt({int maxLength = 100}) => substring(0, min(length, maxLength));

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

// LIST ========================================================================

/// An extension on [List] to give them some extra convenience methods.
extension ExtList on List {
  /// Returns a sublist starting at the beginning of the list and of length
  /// [maxLength] (unless the original list is shorter, in which case it is
  /// returned in full)
  List excerpt({int maxLength = 10}) => sublist(0, min(length, maxLength));
}
