import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/layout/scaffold_fit.dart";
import "../../widgets/menu/desktop_menu.dart";
import "../meta/if_app_is_ready.dart";
import "main_contents.dart";

/// The
class DesktopPageHome extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [DesktopPageHome] matching the given parameters.
  const DesktopPageHome({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ScaffoldFit(
      padding: EdgeInsets.symmetric(horizontal: XLayout.paddingL),
      // overlay: ButtonsOverlay(),
      body: IfAppIsReady(
        child: LayoutBuilder(
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
                child: DesktopMainContents(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
