// Framework dependencies
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/widgets.dart";

/// A widget describing what the site is about.
class HomeDescription extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [HomeDescription] matching the given parameters.
  const HomeDescription({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XContainer(
      padding: EdgeInsets.all(XLayout.paddingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoColorText(
            "Home description 1".tr,
            style: context.textTheme.titleMedium,
          ),
          // XLayout.verticalM,
          // AutoColorText("I also make %bc art%.".tr,
          //   defaultStyle: context.textTheme.titleMedium,
          // ),
        ],
      ),
    );
  }

  // METHODS ===================================================================

}
