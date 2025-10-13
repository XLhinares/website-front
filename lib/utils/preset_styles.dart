import "package:flutter/material.dart";
import "package:get/get.dart";

/// A static class that lists non default styles that I use often.
class PresetStyles {
  /// A text button style with it's background color set to the secondary color of the app.
  static ButtonStyle? secondaryButtonStyle(BuildContext context) =>
      context.theme.textButtonTheme.style?.copyWith(
        backgroundColor:
            WidgetStatePropertyAll(context.theme.colorScheme.secondary),
      );
}
