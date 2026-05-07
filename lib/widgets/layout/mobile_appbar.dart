import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../utils/extensions.dart";

/// A pseudo appbar with a back and a menu button.
///
/// Used on the mobile non-home pages.
class MobileAppbar extends StatelessWidget {
  // VARIABLES =================================================================

  /// The title of the appbar
  final String title;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileAppbar] instance.
  const MobileAppbar({super.key, required this.title});

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    final buttonSize = XLayout.paddingL * 1.5 - 2 * XLayout.paddingXS;

    return Positioned(
      top: XLayout.paddingM,
      right: XLayout.paddingM,
      left: XLayout.paddingM,
      height: XLayout.paddingL * 1.5,
      child: XContainer(
        padding: XLayout.edgeInsetsAllXS,
        color: context.colors.secondary,
        child: Row(
          children: [
            XButton(
              height: buttonSize,
              width: buttonSize,
              color: Colors.transparent,
              enableShadow: false,
              onTap: () => router.goBack(soft: true),
              child: Icon(
                Icons.arrow_back,
                color: context.colors.onSecondary,
              ),
            ),
            Expanded(
              child: Text(
                title.tr,
                style: context.titleMediumOnSecondary,
                textAlign: TextAlign.center,
              ),
            ),
            XButton(
              height: buttonSize,
              width: buttonSize,
              color: Colors.transparent,
              enableShadow: false,
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Icon(
                Icons.menu,
                color: context.colors.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // METHODS ===================================================================
}
