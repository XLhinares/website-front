import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/route.dart";
import "../../widgets/body/mobile_tab_subtitle.dart";
import "../../widgets/body/mobile_tab_title.dart";

/// A preset for tabs displayed on mobile.
class MobileTab extends StatelessWidget {
  // VARIABLES =================================================================

  /// The route leading to this tab.
  final AppRoute route;

  /// The content of the tab.
  final Widget child;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileTab] matching the given parameters.
  const MobileTab({
    super.key,
    required this.route,
    required this.child,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(XLayout.paddingM),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MobileTabTitle(title: "${route.name}_title".tr),
          XLayout.verticalM,
          MobileTabDescription(description: "${route.name}_description".tr),
          XLayout.verticalL,
          child,
          XLayout.verticalL,
          XLayout.verticalL,
        ],
      ),
    );
  }

  // WIDGETS ===================================================================
}
