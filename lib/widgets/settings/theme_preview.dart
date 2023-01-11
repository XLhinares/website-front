import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/utils.dart";

/// A widget allowing the user to preview a theme.
class ThemePreview extends StatelessWidget {
  // VARIABLES =================================================================

  /// The name of the theme being previewed.
  final String name;

  /// The contents of the theme being previewed.
  final ThemeData data;

  // CONSTRUCTOR ===============================================================

  /// Returns a [ThemePreview] matching the given parameters.
  const ThemePreview({
    super.key,
    required this.name,
    required this.data,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: XLayout.brcXS,
      child: XInkContainer(
        padding: EdgeInsets.zero,
        gradient: RadialGradient(
          colors: [
            data.colorScheme.primary,
            data.colorScheme.primary,
            data.colorScheme.background,
            data.colorScheme.background,
          ],
          stops: const [
            0,
            0.4,
            0.8,
            1,
          ],
          radius: 1.5,
          center: Alignment.topLeft,
          // end: Alignment.bottomRight,
        ),
        borderDecoration: settings.theme.value == name
            ? Border.all(width: 2, color: Colors.black45)
            : null,
        onTap: () => settings.theme.value = name,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: context.theme.colorScheme.background.withAlpha(100),
              padding: EdgeInsets.all(XLayout.paddingXS),
              child: Center(child: Text(name)),
            )
          ],
        ),
      ),
    );
  }

// WIDGETS ===================================================================

}
