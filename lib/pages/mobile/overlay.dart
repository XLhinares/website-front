import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../utils/tools.dart";

/// A stack to display an overlay over some content.
///
/// Made to be used on the mobile mode.
class MobileOverlay extends StatelessWidget {
  // VARIABLES =================================================================

  /// Whether to show a button allowing the user to go back.
  final bool showBackButton;

  /// Whether to show a button allowing to open the drawer
  final bool showDrawerButton;

  double get _itemExtent => XLayout.paddingL * 1.5;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of the [MobileOverlay] tab.
  const MobileOverlay({
    super.key,
    this.showBackButton = false,
    this.showDrawerButton = true,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: XLayout.paddingM,
      right: XLayout.paddingM,
      left: XLayout.paddingM,
      height: _itemExtent,
      child: Row(
        children: [
          showBackButton
              ? XButton(
                  width: _itemExtent,
                  height: _itemExtent,
                  borderDecoration: Border.all(
                    color: context.theme.colorScheme.onSurface,
                    width: 2,
                  ),
                  color: context.theme.colorScheme.surface,
                  onTap: () => router.goBack(soft: true),
                  child: Icon(
                    Icons.arrow_back,
                    color: context.colors.onSurface,
                  ),
                )
              : SizedBox(),
          Expanded(child: SizedBox()),
          showDrawerButton
              ? XButton(
                  width: _itemExtent,
                  height: _itemExtent,
                  borderDecoration: Border.all(
                    color: context.theme.colorScheme.onSurface,
                    width: 2,
                  ),
                  color: context.theme.colorScheme.surface,
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Icon(
                    Icons.menu,
                    color: context.colors.onSurface,
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  // METHODS ===================================================================
}
