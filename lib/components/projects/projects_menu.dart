import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../menu/desktop_title.dart";
import "projects_menu_list.dart";

/// The half of the body containing the title and the menu.
class ProjectsMenu extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ProjectsMenu] matching the given parameters.
  const ProjectsMenu({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
      child: Column(
        children: [
          // TITLE ---------------------------------------------------------------
          // XInkContainer(
          //   child: Row(
          //     children: [
          //       XeppelinLogo(
          //         size: 2 * XLayout.paddingL,
          //       ),
          //       XLayout.horizontalXS,
          //       Text(
          //         "Xeppelin",
          //         style: context.textTheme.displayLarge,
          //       ),
          //     ],
          //   ),
          //   onTap: () => router.pop(),
          // ),
          const BodyTitle(),

          // SEPARATOR
          XLayout.verticalM,

          Expanded(
            child: XContainer(
              padding: EdgeInsets.all(XLayout.paddingM),
              child: ProjectsMenuListView(),
            ),
          ),
        ],
      ),
    );
  }

// METHODS ===================================================================
}
