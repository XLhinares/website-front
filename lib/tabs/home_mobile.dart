// Framework dependencies
import "package:flutter/material.dart";

// Project dependencies
import "../widgets/body/body.dart";

/// The app body as it should
class HomeMobile extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [HomeMobile] matching the given parameters.
  const HomeMobile({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xeppelin"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          MobileProjects(),
          BodyContentsContact(),
        ],
      ),
    );
  }

// WIDGETS ===================================================================

}
