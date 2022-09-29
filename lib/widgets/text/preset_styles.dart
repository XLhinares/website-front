import "package:flutter/material.dart";
import "package:get/get.dart";

/// A dataclass handling the different style presets by name.
///
/// It is important that the styles are defined in the [TextTheme.of(context)].
class PresetStyle {

  // VARIABLES =================================================================

  /// A unique name identifying the preset.
  final String name;

  /// The style preset for display-type text.
  ///
  /// It is important to define [Theme.of(context).textTheme.displayMedium] for
  /// it to work as expected.
  static const display = PresetStyle._internal("display");

  /// The style preset for title-type text.
  ///
  /// It is important to define [Theme.of(context).textTheme.titleMedium] for
  /// it to work as expected.
  static const title = PresetStyle._internal("title");

  /// The style preset for headline-type text.
  ///
  /// It is important to define [Theme.of(context).textTheme.headlineMedium] for
  /// it to work as expected.
  static const headline = PresetStyle._internal("headline");

  /// The style preset for body-type text.
  ///
  /// It is important to define [Theme.of(context).textTheme.bodyMedium] for
  /// it to work as expected.
  static const body = PresetStyle._internal("body");

  /// The style preset for label-type text.
  ///
  /// It is important to define [Theme.of(context).textTheme.labelMedium] for
  /// it to work as expected.
  static const label = PresetStyle._internal("label");


  // CONSTRUCTOR ===============================================================

  const PresetStyle._internal(this.name);

  // METHODS ===================================================================

  /// Gets the contextualized style.
  TextStyle? getStyle (BuildContext context) {
    switch (this) {
      case PresetStyle.display:
        return context.textTheme.displayMedium;
      case PresetStyle.title:
        return context.textTheme.titleMedium;
      case PresetStyle.headline:
        return context.textTheme.headlineMedium;
      case PresetStyle.body:
        return context.textTheme.bodyMedium;
      case PresetStyle.label:
        return context.textTheme.labelMedium;
      default:
        return null;
    }
  }

}