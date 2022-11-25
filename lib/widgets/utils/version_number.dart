import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/globals.dart";

/// Display the version number of the app for versioning purposes.
class VersionNumber extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [VersionNumber] matching the given parameters.
  const VersionNumber({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Visibility(
      // visible: true,
      visible: kDebugMode,
      child: XContainer(
        width: 5 * XLayout.paddingL,
        child: const Text("Xeppelin - $versionNumber"),
      ),
    );
  }
}
