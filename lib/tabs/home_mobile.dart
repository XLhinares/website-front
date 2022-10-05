import "package:flutter/material.dart";

import "../widgets/widgets.dart";
import "../components/components.dart";

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
      body: Stack(
        children: [
          // BACKGROUND --------------------------------------------------------
          const AnimatedBackground(scale: 0.3,),

          // FOREGROUND --------------------------------------------------------
          ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: const [
              MobileHome(),
              MobileProjects(),
              MobileContact(),
            ],
          ),
        ],
      ),
    );
  }

// WIDGETS ===================================================================

}
