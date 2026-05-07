import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/app_route.dart";
import "../../globals.dart";
import "../../widgets/animations/rotating_icon.dart";
import "../../widgets/body/drawer_item.dart";
import "../../widgets/images/xeppelin_logo.dart";

/// A custom drawer allowing the user to navigate the app in mobile mode.
class CustomDrawer extends StatelessWidget {
  // VARIABLES =================================================================

  /// Whether the drawer is currently open
  final RxBool isMaximized;

  /// The current horizontal extent of the drawer.
  final RxDouble width;

  /// The minimum width of the drawer when it's displayed.
  final double _minWidth;

  /// The maximum width of the drawer when it's displayed.
  final double _maxWidth;

  // GETTERS ===================================================================

  /// The height of the title box (where the logo is displayed).
  double get titleBoxHeight => _minWidth;

  double get _halfOpenWidth => _minWidth + (_maxWidth - _minWidth) * 0.5;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of the [CustomDrawer] tab.
  CustomDrawer({
    super.key,
  })  : isMaximized = false.obs,
        _minWidth = 2 * XLayout.paddingL,
        _maxWidth = 6 * XLayout.paddingL,
        width = (2 * XLayout.paddingL).obs {
    ever<double>(width, (callback) => _clampWidth());
  }

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(XLayout.paddingS),
      child: Obx(() => AnimatedSize(
            duration: Durations.short1,
            child: GestureDetector(
              onHorizontalDragUpdate: onHorizontalDragUpdate,
              child: SizedBox(
                width: width.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    XButton(
                      margin: EdgeInsets.zero,
                      height: titleBoxHeight,
                      color: context.theme.colorScheme.secondary,
                      child: const XeppelinLogo(),
                    ),
                    XLayout.verticalS,
                    XContainer(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.all(XLayout.paddingXS),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          getItem(
                            AppRoute.MAIN_HOME,
                          ),
                          getItem(
                            AppRoute.MAIN_PROJECTS,
                          ),
                          getItem(
                            AppRoute.MAIN_PEOPLE,
                          ),
                          getItem(
                            AppRoute.MAIN_SETTINGS,
                          ),
                          XButton(
                            color: context.theme.colorScheme.surface,
                            height: XLayout.paddingL,
                            padding: EdgeInsets.zero,
                            margin: XLayout.edgeInsetsAllXS,
                            onTap: toggleExpansion,
                            child: RotatingIcon(
                              tag: "custom_drawer_toggle",
                              observed: isMaximized,
                              duration: animDurationShort,
                              step: 0.5,
                              alternateRotation: true,
                              builder: (context) =>
                                  const Icon(Icons.double_arrow_rounded),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  // METHODS ===================================================================

  /// Alternates between the short and the long shape of the drawer.
  void toggleExpansion() {
    if (isMaximized.isTrue) {
      minimizeDrawer();
    } else if (isMaximized.isFalse) {
      maximizeDrawer();
    }
  }

  /// Sets the drawer to its maximum width.
  void maximizeDrawer() {
    width.value = _maxWidth;
  }

  /// Sets the drawer to its minimum width.
  void minimizeDrawer() {
    width.value = _minWidth;
  }

  /// Behavior during horizontal drag event.
  ///
  /// The width is clamped by the worker set in the initialization.
  void onHorizontalDragUpdate(DragUpdateDetails details) {
    width.value += details.delta.dx;
  }

  /// Behavior at the end of the drag event.
  ///
  /// If the drag happened fast enough in one direction,
  /// then the drawer is opened or closed accordingly;
  /// otherwise, the drawer is opened or closed according to the width at the end of the drag.
  void onHorizontalDragEnd(DragEndDetails details) {
    Get.log("Deciding drawer drag end behavior:");
    if (details.velocity.pixelsPerSecond.dx > 10) {
      Get.log("> Maximizing (high speed)");
      maximizeDrawer();
    } else if (details.velocity.pixelsPerSecond.dx < -10) {
      Get.log("> Minimizing (high speed)");
      minimizeDrawer();
    } else if (width < _halfOpenWidth) {
      Get.log("> Minimizing (low speed)");
      minimizeDrawer();
    } else if (width >= _halfOpenWidth) {
      Get.log("> Maximizing (low speed)");
      maximizeDrawer();
    }
  }

  /// Clamps the width of the drawer between [_minWidth] and [_maxWidth].
  /// Also updates [isMaximized] accordingly.
  void _clampWidth() {
    if (width.value >= _maxWidth) {
      width.value = _maxWidth;
      isMaximized.value = true;
    } else if (width.value <= _minWidth) {
      width.value = _minWidth;
      isMaximized.value = false;
    }
  }

  // WIDGETS ===================================================================

  /// Returns a [DrawerItem] matching the given mode.
  Widget getItem(AppRoute route) => DrawerItem(
        route: route,
        minWidth: _minWidth,
        maxWidth: _maxWidth,
      );
}
