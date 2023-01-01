import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:responsive_framework/responsive_framework.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/dataclass/project_metadata.dart";
import "../../components/components.dart";
import "../../utils/utils.dart";

/// The content of the body in the "ProjectPreviews" mode.
class DesktopProjects extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [DesktopProjects] matching the given parameters.
  const DesktopProjects({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: router,
        builder: (context) => router.project == null
            ? ProjectLoader(
                renderingStrategy: (list) => ResponsiveGridView.builder(
                  gridDelegate: ResponsiveGridDelegate(
                      mainAxisSpacing: XLayout.paddingL,
                      crossAxisSpacing: XLayout.paddingL,
                      crossAxisExtent: Get.height * 0.3,
                      childAspectRatio: 3 / 4),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(XLayout.paddingM),
                  itemCount: list.length,
                  itemBuilder: (context, index) =>
                      _projectBuilder(context, list[index]),
                ),
              )
            : ProjectFocus(
                name: router.project!,
                onBack: () => router.selectProject(null),
              ));
  }

  // METHODS ===================================================================

  Widget _projectBuilder(BuildContext context, ProjectMetadata project) =>
      ProjectPreviewer(
        project: project,
        onTap: () => router.selectProject(project.name),
      );
}
