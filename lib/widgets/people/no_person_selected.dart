import "package:flutter/widgets.dart";
import "package:get/get.dart";

import "../../utils/extensions.dart";
import "../text/auto_color_text.dart";

///
class NoPersonSelected extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [NoPersonSelected] instance.
  const NoPersonSelected({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return AutoColorText(
      "no_person_selected".tr,
      color: context.labelMediumOnSurface.asHint.color,
      style: context.labelMediumOnSurface.asHint,
    );
  }

  // METHODS ===================================================================
}
