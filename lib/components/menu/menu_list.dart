import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/animations/menu_selection_animation_controller.dart";
import "../../../classes/dataclass/app_mode.dart";
import "../../../utils/globals.dart";
import "menu.dart";

/// The list view containing the menu items.
class MenuList extends StatelessWidget {
  // VARIABLES =================================================================

  late final MenuSelectionAnimationController _animationController;

  final GlobalKey _keyHome = GlobalKey();
  final GlobalKey _keyProjects = GlobalKey();
  final GlobalKey _keyContacts = GlobalKey();
  final GlobalKey _keySettings = GlobalKey();
  final GlobalKey _keyDivider = GlobalKey();

  // CONSTRUCTOR ===============================================================

  /// Returns a [MenuList] matching the given parameters.
  MenuList({super.key}) {
    _animationController = Get.put(MenuSelectionAnimationController(
      length: AppMode.mainTabs.length,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) => _animationController
      ..setTileHeight(0, _keyHome.currentContext?.size?.height ?? 0)
      ..setTileHeight(1, _keyProjects.currentContext?.size?.height ?? 0)
      ..setTileHeight(2, _keyContacts.currentContext?.size?.height ?? 0)
      ..setTileHeight(3, _keySettings.currentContext?.size?.height ?? 0)
      ..setPadding(_keyDivider.currentContext?.size?.height ?? 0)
      ..selectTile(router.modeIndex));

    // Reload the tile sizes when the locale change so the new strings don't
    // cause an overflow.
    ever(
        settings.locale,
        (_) => WidgetsBinding.instance
            .addPostFrameCallback((_) => _animationController
              ..setTileHeight(0, _keyHome.currentContext?.size?.height ?? 0)
              ..setTileHeight(1, _keyProjects.currentContext?.size?.height ?? 0)
              ..setTileHeight(2, _keyContacts.currentContext?.size?.height ?? 0)
              ..setTileHeight(3, _keySettings.currentContext?.size?.height ?? 0)
              ..setPadding(_keyDivider.currentContext?.size?.height ?? 0)));
  }

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // MENU ITEMS ------------------------------------------------
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _tile(
              key: _keyHome,
              mode: AppMode.home,
            ),
            Divider(
              key: _keyDivider,
            ),
            _tile(
              key: _keyProjects,
              mode: AppMode.projects,
            ),
            const Divider(),
            _tile(
              key: _keyContacts,
              mode: AppMode.contact,
            ),
            const Divider(),
            _tile(
              key: _keySettings,
              mode: AppMode.settings,
            ),
          ],
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
