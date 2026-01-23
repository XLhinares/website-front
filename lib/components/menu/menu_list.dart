import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/route.dart";
import "../../globals.dart";
import "../../utils/tools.dart";
import "menu_tile.dart";

/// The list view containing the menu items.
class MenuList extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [MenuList] matching the given parameters.
  const MenuList({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: router,
        builder: (_) {
          dlog("rebuilding...");
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: AppRoute.mainRoutes.length,
            padding: XLayout.edgeInsetsAllM,
            itemBuilder: (context, index) => MenuTile(
              route: AppRoute.mainRoutes[index],
            ),
            separatorBuilder: (context, index) {
              if (index != 0) return const Divider();
              return Divider();
            },
          );
        });
  }
}
