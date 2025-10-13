import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../classes/dataclass/background_data.dart";
import "../../utils/globals.dart";

/// The background used in our scaffold widgets.
///
/// It refreshes when the value of [cookie.background] changes.
class ScaffoldBackground extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ScaffoldBackground] matching the given parameters.
  const ScaffoldBackground({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedSwitcher(
          duration: animDurationLong,
          child: BackgroundData.current().builder(context) ?? const SizedBox(),
        ));
  }

// METHODS ===================================================================
}
