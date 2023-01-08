import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/utils.dart";
import "../../widgets/widgets.dart";

/// The different buttons that allow the using to change some settings.
class ButtonsOverlay extends StatelessWidget {
  // VARIABLES =================================================================

  /// The size of a button.
  final double buttonSize = 2 * XLayout.paddingL;

  // CONSTRUCTOR ===============================================================

  /// Returns a [ButtonsOverlay] matching the given parameters.
  ButtonsOverlay({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: FittedBox(
        child: Padding(
          padding: EdgeInsets.all(XLayout.paddingM),
          child: Row(
            children: [
              // DARK THEME
              CircularButton(
                size: buttonSize,
                onTap: () => settings.rotateTheme(),
                child: RotatingIcon(
                  builder: (_) =>
                      Icon(Icons.light_mode_outlined, size: buttonSize * 0.8),
                  observed: settings.theme,
                  tag: "button_theme",
                ),
              ),

              XLayout.horizontalM,

              // LOCALE
              CircularButton(
                size: buttonSize,
                onTap: settings.rotateLocale,
                child: RotatingIcon(
                  builder: (_) => Text(
                    settings.locale.value.capitalize!,
                    style: context.textTheme.titleMedium,
                  ),
                  observed: settings.locale,
                  tag: "button_locale",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// WIDGETS ===================================================================

}
