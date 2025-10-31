import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../utils/globals.dart";
import "../../classes/controllers/menu_selection_animation_controller.dart";
import "../../classes/dataclass/route.dart";

/// A tile displaying one menu element.
class MenuTile extends StatelessWidget {
  // VARIABLES =================================================================

  /// The route this [MenuTile] is about.
  final AppRoute route;

  /// The controller of the menu selection animation.
  ///
  /// This is used to call the tile selection when the tile is tapped.
  final MenuSelectionAnimationController controller;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MenuTile] matching the given parameters.
  const MenuTile({
    super.key,
    required this.route,
    required this.controller,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard.text(
      enableShadow: false,
      onTap: () {
        printInfo(info: "\nEVENT: Menu tile ${route.path} was tapped.");

        /// Abort if the route is not accessible to the user.
        if (!route.isAccessibleToUser) return;

        final int index = AppRoute.mainRoutes.indexOf(route);
        controller.selectTile(index);
        router.push(route: route);
      },
      padding: EdgeInsets.all(XLayout.paddingM),
      internalHorizontalPadding: XLayout.paddingM,
      title: "tab_${route.name}".tr,
      content: "tab_${route.name}_description".tr,
      leading: Icon(
        route.icon,
        size: XLayout.paddingL,
      ),
    );
  }

// WIDGETS ===================================================================
}
