import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/dataclass/project_metadata.dart";
import "../../widgets/widgets.dart";

/// A preview of a project.
class ProjectPreviewer extends StatelessWidget {
  // VARIABLES =================================================================

  /// The project being previewed.
  final ProjectMetadata project;

  /// The behavior when the box is tapped.
  final void Function()? onTap;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ProjectPreviewer] matching the given parameters.
  const ProjectPreviewer({
    super.key,
    required this.project,
    this.onTap,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XInkContainer(
      height: Get.height * 0.25,
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Stack(
        children: [
          // IMAGE -------------------------------------------------------------
          Positioned.fill(
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: XLayout.brcXS,
              child: CoveringNetworkImage(
                project.preview,
              ),
            ),
          ),

          Positioned.fill(
            child: Column(
              children: [
                const Expanded(flex: 3, child: SizedBox()),
                XContainer(
                  borderRadius: BorderRadius.zero,
                  color: context.theme.colorScheme.background.withOpacity(0.9),
                  padding: EdgeInsets.all(XLayout.paddingM),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // NAME ------------------------------------------------------
                      Text(
                        project.name,
                        style: context.textTheme.titleMedium,
                      ),

                      XLayout.verticalXS,
                      const Divider(),
                      XLayout.verticalXS,

                      // SUMMARY ---------------------------------------------------
                      Text(
                        project.summary,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
