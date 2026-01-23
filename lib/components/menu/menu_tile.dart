import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../classes/dataclass/route.dart";
import "../../utils/tools.dart";

/// A tile displaying one menu element.
class MenuTile extends StatelessWidget {
  // VARIABLES =================================================================

  /// The route this [MenuTile] is about.
  final AppRoute route;

  bool get _isSelected => route == router.mainTab;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MenuTile] matching the given parameters.
  const MenuTile({
    super.key,
    required this.route,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard.text(
      color: _isSelected ? context.colors.secondary : Colors.transparent,
      enableShadow: false,
      onTap: () {
        router.goTo(route);
      },
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(XLayout.paddingM),
      internalHorizontalPadding: XLayout.paddingM,
      title: "tab_${route.name}".tr,
      content: "tab_${route.name}_description".tr,
      titleStyle: _isSelected
          ? context.titleMediumOnSecondary
          : context.textTheme.titleMedium,
      contentStyle: _isSelected
          ? context.bodyMediumOnSecondary
          : context.textTheme.bodyMedium,
      leading: Icon(
        route.icon,
        size: XLayout.paddingL,
        color:
            _isSelected ? context.colors.onSecondary : context.colors.onPrimary,
      ),
    );
  }

// WIDGETS ===================================================================
}
