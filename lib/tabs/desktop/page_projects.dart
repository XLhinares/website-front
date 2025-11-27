import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../components/misc/if_app_is_ready.dart";
import "../../components/projects/projects_menu.dart";
import "../../widgets/layout/scaffold_fit.dart";
import "projects_content.dart";

/// The
class DesktopPageProjects extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [DesktopPageProjects] matching the given parameters.
  const DesktopPageProjects({super.key});

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
                child: const ProjectsMenu(),
              ),

              XLayout.horizontalL,

              // CONTENTS --------------------------------------------------
              Expanded(
                child: DesktopProjectsContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
