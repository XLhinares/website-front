import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/controllers/menu_selection_animation_controller.dart";
import "../../../classes/dataclass/app_mode.dart";
import "../../../utils/globals.dart";
import "menu.dart";

/// The list view containing the menu items.
class MenuList extends StatelessWidget {
  // VARIABLES =================================================================

  late final MenuSelectionAnimationController _animationController;

  late final List<GlobalKey> _keys;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MenuList] matching the given parameters.
  MenuList({super.key}) {
    _keys = List.generate(AppMode.mainTabs.length + 1, (index) => GlobalKey());

    _animationController = Get.put(MenuSelectionAnimationController(
      length: AppMode.mainTabs.length,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < AppMode.mainTabs.length; i++) {
        _animationController.setTileHeight(
            i, _keys[i].currentContext?.size?.height ?? 0);
      }
      _animationController
          .setPadding(_keys.last.currentContext?.size?.height ?? 0);
      _animationController.selectTile(router.modeIndex);
    });

    // Reload the tile sizes when the locale change so the new strings don't
    // cause an overflow.
    ever(
      settings.locale,
      (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        for (int i = 0; i < AppMode.mainTabs.length; i++) {
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
          itemCount: AppMode.mainTabs.length,
          itemBuilder: (context, index) => _tile(
            key: _keys[index],
            mode: AppMode.mainTabs[index],
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
    required AppMode mode,
  }) =>
      MenuTile(
        key: key,
        mode: mode,
        controller: _animationController,
      );
}
