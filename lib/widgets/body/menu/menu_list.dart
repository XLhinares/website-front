import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/animations/menu_selection_animation_controller.dart";
import "../../../classes/dataclass/app_mode.dart";
import "../../../utils/globals.dart";
import "menu_tile.dart";

/// The list view containing the menu items.
class MenuList extends StatelessWidget {

  // VARIABLES =================================================================

  late final MenuSelectionAnimationController _animationController;

  final GlobalKey _keyHome = GlobalKey();
  final GlobalKey _keyProjects = GlobalKey();
  final GlobalKey _keyContacts = GlobalKey();
  final GlobalKey _keyDivider = GlobalKey();

  // CONSTRUCTOR ===============================================================

  /// Returns a [MenuList] matching the given parameters.
  MenuList({super.key}) {

    _animationController = Get.put(MenuSelectionAnimationController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.addTileHeight(_keyHome.currentContext?.size?.height ?? 0);
      _animationController.addTileHeight(_keyProjects.currentContext?.size?.height ?? 0);
      _animationController.addTileHeight(_keyContacts.currentContext?.size?.height ?? 0);
      _animationController.setPadding(_keyDivider.currentContext?.size?.height ?? 0);
    });
  }

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        // ANIMATED BOX ----------------------------------------------
        GetBuilder(
          // Gets rebuilt every time the animation controller is
          // updated.
          init: _animationController,
          builder: (_) => Column(
            children: [

              // An invisible box that pushes the grey box down to
              // match the start of the selected tile.
              AnimatedSize(
                duration: animDurationLong,
                child: SizedBox(
                  height: _animationController.offset,
                  // width: 0,
                ),
              ),

              // A grey box that goes behind the selected tile to
              // highlight it.
              AnimatedSize(
                duration: animDurationLong,
                child: XContainer(
                  color: Colors.grey.withAlpha(100),
                  enableShadow: false,
                  height: _animationController.height,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),


        // MENU ITEMS ------------------------------------------------
        ListView(
          shrinkWrap: true,
          children: [
            MenuTile(
              key: _keyHome,
              mode: AppMode.home,
              onTap: () => _animationController.selectTile(0),
            ),
            Divider(key: _keyDivider,),
            MenuTile(
              key: _keyProjects,
              mode: AppMode.projects,
              onTap: () => _animationController.selectTile(1),
            ),
            const Divider(),
            MenuTile(
              key: _keyContacts,
              mode: AppMode.contact,
              onTap: () => _animationController.selectTile(2),
            ),
          ],
        ),
      ],
    );
  }

  // WIDGETS ===================================================================

}
