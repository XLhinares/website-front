// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

// Project dependencies
import "package:website_front/utils/globals.dart";
import "package:website_front/widgets/interactables/circular_button.dart";

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
    return Padding(
      padding: EdgeInsets.all(XLayout.paddingM),
      child: Column(
        children: [
          const Expanded(child: SizedBox(),),
          Row(
            children: [

              // DARK THEME ----------------------------------------------------
              Obx(() => CircularButton(
                size: buttonSize,
                onTap: () => settings.toggleTheme(),
                icon: settings.darkTheme.value
                    ? Icons.light_mode_outlined
                    : Icons.mode_night,
              ),),

              XLayout.horizontalM,

              // LOCALE --------------------------------------------------------
              CircularButton(
                size: buttonSize,
                onTap: settings.rotateLocale,
                child: Obx(() => Text(
                  settings.locale.value.capitalize!,
                  style: context.textTheme.titleMedium,
                ),),
              ),
            ],
          ),
        ],
      ),
    );
  }

// METHODS ===================================================================

}
