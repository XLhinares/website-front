import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/globals.dart";
import "../text/preset_text.dart";
import "circular_button.dart";

/// The different buttons that allow the using to change some settings.
class Buttons extends StatelessWidget {
  // VARIABLES =================================================================

  /// The size of a button.
  final double buttonSize = 2 * XLayout.paddingL;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [Buttons] matching the given parameters.
  Buttons({Key? key}) : super(key: key);

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // DARK THEME ----------------------------------------------------
        Obx(
          () => CircularButton(
            size: buttonSize,
            onTap: () => settings.toggleTheme(),
            icon: settings.darkTheme.value
                ? Icons.light_mode_outlined
                : Icons.mode_night,
          ),
        ),

        XLayout.horizontalM,

        // LOCALE --------------------------------------------------------
        CircularButton(
          size: buttonSize,
          onTap: settings.rotateLocale,
          child: Obx(
            () => PresetText.title(
              settings.locale.value.capitalize!,
            ),
          ),
        ),
      ],
    );
  }

// METHODS ===================================================================

}
