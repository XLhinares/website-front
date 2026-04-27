import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/route.dart";
import "../../globals.dart";
import "../../pages/mobile/drawer.dart";

/// An item for the [CustomDrawer], it represents an [AppMode] that the user can access.
///
/// Its width can vary from [minWidth] to [maxWidth].
class DrawerItem extends StatelessWidget {
  // VARIABLES =================================================================

  /// The mode that the item represents.
  final AppRoute route;

  /// The minimum width of the item.
  final double minWidth;

  /// The maximum width of the item.
  final double maxWidth;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [DrawerItem] matching the given parameters.
  const DrawerItem({
    super.key,
    required this.route,
    required this.minWidth,
    required this.maxWidth,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: minWidth,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          GetBuilder(
              init: router,
              builder: (_) {
                return XButton(
                  color: router.currentRoute == route
                      ? context.theme.colorScheme.secondary
                      : context.theme.colorScheme.surface,
                  width: minWidth - 2 * XLayout.paddingS,
                  margin: XLayout.edgeInsetsAllXS,
                  onTap: goToMode,
                  child: Icon(
                    route.icon,
                    color: router.currentRoute == route
                        ? context.theme.colorScheme.onSecondary
                        : context.theme.colorScheme.onSurface,
                    // width: XLayout.paddingL * 0.75,
                    // height: XLayout.paddingL * .75,
                  ),
                );
              }),
          XButton.text(
            route.name.tr.capitalizeFirst!,
            margin: XLayout.edgeInsetsAllXS,
            width: maxWidth - minWidth - XLayout.paddingS,
            color: context.theme.colorScheme.surface,
            onTap: goToMode,
          ),
        ],
      ),
    );
  }

  // METHODS ===================================================================

  /// Tell the router to go this mode.
  void goToMode() {
    router.goTo(route);
  }
}
