import "package:flutter/material.dart";

import "../components/components.dart";

/// The go-to tab to display when content was not found.
class TabNotFound extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [TabNotFound] matching the given parameters.
  const TabNotFound({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NotFound(),
    );
  }

  // WIDGETS ===================================================================

}
