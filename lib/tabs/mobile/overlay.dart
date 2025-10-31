import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/exports.dart";
import "../../widgets/interactables/overlay_button.dart";

/// A stack to display an overlay over some content.
///
/// Made to be used on the mobile mode.
class MobileOverlay extends StatelessWidget {
  // VARIABLES =================================================================

  /// The child to display under the overlay.
  final Widget child;

  /// Whether to show a button allowing the user to go back.
  final bool showBackButton;

  /// Whether to show a button allowing to open the drawer
  final bool showDrawerButton;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of the [MobileOverlay] tab.
  const MobileOverlay({
    super.key,
    required this.child,
    this.showBackButton = false,
    this.showDrawerButton = true,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child),
        showBackButton
            ? OverlayButton(
                top: XLayout.paddingM,
                left: XLayout.paddingM,
                onTap: () => router.pop(),
                child: Icon(
                  Icons.arrow_back,
                ),
              )
            : SizedBox(),
        showDrawerButton
            ? OverlayButton(
                top: XLayout.paddingM,
                right: XLayout.paddingM,
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Icon(
                  Icons.menu,
                ),
              )
            : SizedBox(),
      ],
    );
  }

  // METHODS ===================================================================
}
