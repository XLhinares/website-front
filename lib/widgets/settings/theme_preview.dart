import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../utils/tools.dart";

/// A widget allowing the user to preview a theme.
class ThemePreview extends StatelessWidget {
  // VARIABLES =================================================================

  /// The name of the theme being previewed.
  final String name;

  /// The contents of the theme being previewed.
  final ThemeData data;

  // CONSTRUCTOR ===============================================================

  /// Returns a [ThemePreview] matching the given parameters.
  const ThemePreview({super.key, required this.name, required this.data});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: XLayout.brcXS,
      child: XButton(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        gradient: RadialGradient(
          colors: [
            data.colorScheme.secondary,
            data.colorScheme.secondary,
            data.colorScheme.primary,
            data.colorScheme.primary,
            data.colorScheme.surface,
            data.colorScheme.surface,
          ],
          stops: const [0, .10, .25, .5, .8, 1],
          radius: 1.5,
          center: Alignment.topLeft,
          // end: Alignment.bottomRight,
        ),
        borderDecoration: app.cookies.theme.value == name
            ? Border.all(width: 2, color: Colors.black45)
            : null,
        onTap: () => app.cookies.theme.value = name,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: context.theme.colorScheme.surface.withAlpha(150),
              padding: EdgeInsets.all(XLayout.paddingXS),
              child: Center(
                child: AutoSizeText(
                  name,
                  maxLines: 1,
                  style: context.bodyMediumOnSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGETS ===================================================================
}
