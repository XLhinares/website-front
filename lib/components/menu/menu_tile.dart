import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/dataclass/app_mode.dart";
import "../../../utils/globals.dart";
import "../../classes/controllers/menu_selection_animation_controller.dart";

/// A tile displaying one menu element.
class MenuTile extends StatelessWidget {
  // VARIABLES =================================================================

  /// The mode this [MenuTile] is about.
  final AppMode mode;

  /// The controller of the menu selection animation.
  ///
  /// This is used to call the tile selection when the tile is tapped.
  final MenuSelectionAnimationController controller;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MenuTile] matching the given parameters.
  const MenuTile({
    super.key,
    required this.mode,
    required this.controller,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard.text(
      enableShadow: false,
      onTap: () {
        printInfo(info: "\nEVENT: Menu tile ${mode.name} was tapped.");

        /// Abort if the mode is not accessible to the user.
        if (!mode.isAccessibleToUser) return;

        final int index = AppMode.mainTabs.indexOf(mode);
        controller.selectTile(index);
        router.push(mode: mode);
      },
      padding: EdgeInsets.all(XLayout.paddingM),
      internalHorizontalPadding: XLayout.paddingM,
      title: "tab_${mode.name}".tr,
      content: "tab_${mode.name}_description".tr,
      leading: Icon(
        mode.icon,
        size: XLayout.paddingL,
      ),
    );
  }

// WIDGETS ===================================================================
}
