import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../components/components.dart";
import "../../widgets/widgets.dart";
import "desktop.dart";

/// The
class DesktopTabManager extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [DesktopTabManager] matching the given parameters.
  const DesktopTabManager({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ScaffoldFit(
      padding: EdgeInsets.symmetric(horizontal: XLayout.paddingL),
      background: const AnimatedBackground(
        scale: 0.2,
      ),
      overlay: ButtonsOverlay(),
      body: LayoutBuilder(
        builder: (context, constraints) => Row(
          children: [
            // TITLE -----------------------------------------------------
            SizedBox(
              width: (constraints.maxWidth - 4 * XLayout.paddingL) / 3,
              child: const BodyMenu(),
            ),

            XLayout.horizontalL,

            // CONTENTS --------------------------------------------------
            const Expanded(
              child: BodyContents(),
            ),
          ],
        ),
      ),
    );
  }
}
