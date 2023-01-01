import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/project_metadata.dart";
import "../../components/components.dart";
import "../../utils/utils.dart";

/// The "project" tab adapted for mobile.
class MobileProjects extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileProjects] matching the given parameters.
  const MobileProjects({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: router,
        builder: (context) {
          return router.project == null
              ? ProjectLoader(
                  limit: 4,
                  renderingStrategy: (list) => ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) =>
                        _projectBuilder(context, list[index]),
                    separatorBuilder: (context, index) => XLayout.verticalS,
                  ),
                )
              : ProjectMobileFocus(name: router.project!);
        });
  }

  // METHODS ===================================================================

  Widget _projectBuilder(BuildContext context, ProjectMetadata project) =>
      ProjectWidePreview(
        project: project,
        onTap: () => router.selectProject(project.name),
      );
}
