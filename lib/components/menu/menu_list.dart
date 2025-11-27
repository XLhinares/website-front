import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/controllers/menu_selection_animation_controller.dart";
import "../../globals.dart";
import "../../classes/dataclass/route.dart";
import "menu_tile.dart";

/// The list view containing the menu items.
class MenuList extends StatelessWidget {
  // VARIABLES =================================================================

  late final MenuSelectionAnimationController _animationController;

  late final List<GlobalKey> _keys;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MenuList] matching the given parameters.
  MenuList({super.key}) {
    _keys =
        List.generate(AppRoute.mainRoutes.length + 1, (index) => GlobalKey());

    _animationController = Get.put(MenuSelectionAnimationController(
      length: AppRoute.mainRoutes.length,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < AppRoute.mainRoutes.length; i++) {
        _animationController.setTileHeight(
            i, _keys[i].currentContext?.size?.height ?? 0);
      }
      _animationController
          .setPadding(_keys.last.currentContext?.size?.height ?? 0);
      _animationController.selectTile(router.routeIndex);
    });

    // Reload the tile sizes when the locale change so the new strings don't
    // cause an overflow.
    ever(
      cookies.locale,
      (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        for (int i = 0; i < AppRoute.mainRoutes.length; i++) {
          _animationController.setTileHeight(
              i, _keys[i].currentContext?.size?.height ?? 0);
        }
        _animationController
            .setPadding(_keys.last.currentContext?.size?.height ?? 0);
      }),
    );
  }

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // MENU ITEMS ------------------------------------------------
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: AppRoute.mainRoutes.length,
          itemBuilder: (context, index) => _tile(
            key: _keys[index],
            route: AppRoute.mainRoutes[index],
          ),
          separatorBuilder: (context, index) {
            if (index != 0) return const Divider();
            return Divider(
              key: _keys.last,
            );
          },
        ),

        // ANIMATED BOX ----------------------------------------------
        GetBuilder(
          // Gets rebuilt every time the animation controller is
          // updated.
          init: _animationController,
          builder: (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // An invisible box that pushes the grey box down to
              // match the start of the selected tile.
              AnimatedSize(
                duration: animDurationLong,
                child: SizedBox(
                  height: _animationController.offset,
                  width: 0,
                ),
              ),

              // A grey box that goes behind the selected tile to
              // highlight it.
              AnimatedSize(
                duration: animDurationLong,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: XLayout.brcXS,
                      color: Colors.grey.withAlpha(100),
                    ),
                    height: _animationController.height,
                    width: double.infinity,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

// WIDGETS ===================================================================

  Widget _tile({
    required GlobalKey key,
    required AppRoute route,
  }) =>
      MenuTile(
        key: key,
        route: route,
        controller: _animationController,
      );
}
