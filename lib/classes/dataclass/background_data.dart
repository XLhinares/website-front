import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../utils/globals.dart";
import "../../widgets/background/animated_background_wave.dart";

/// A dataclass with the information required to display a background.
class BackgroundData {
  // CONSTANTS =================================================================

  /// No background
  static BackgroundData none = BackgroundData._internal(
    name: "none",
    builder: (context) => null,
    preview: (context) =>
        ColoredBox(color: context.theme.colorScheme.background),
  );

  /// An animated wave moving in the background.
  static BackgroundData wave = BackgroundData._internal(
    name: "wave",
    builder: (context) => const AnimatedBackgroundWave(scale: 0.3),
    preview: (context) => const AnimatedBackgroundWave(scale: 0.6),
  );

  /// All the know [BackgroundData] values.
  ///
  /// Used to display the list of possible backgrounds in the settings menu.
  static List<BackgroundData> values = [none, wave];

  // VARIABLES =================================================================

  /// The identifier of the background.
  ///
  /// It should be possible to display this name in the settings menu.
  final String name;

  /// A function returning how to build this background according to the context.
  final Widget? Function(BuildContext context) builder;

  /// A function returning how to build a preview according to the context.
  final Widget? Function(BuildContext context) preview;

  // CONSTRUCTOR ===============================================================

  /// Adds the default, light and dark themes to the [BackgroundData].
  const BackgroundData._internal({
    required this.name,
    required this.builder,
    Widget? Function(BuildContext)? preview,
  }) : preview = preview ?? builder;

  /// The currently used background according to the context.
  static BackgroundData current() => parse(cookies.background.value);

  /// Attempts to match the given string with a known background.
  static BackgroundData parse(String source) {
    for (final value in values) {
      if (source.toLowerCase() == value.name) return value;
    }
    return none;
  }
}
