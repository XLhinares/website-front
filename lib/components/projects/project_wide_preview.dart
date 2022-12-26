import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/dataclass/project_preview.dart";
import "../../widgets/widgets.dart";

/// A preview of a project.
class ProjectWidePreview extends StatelessWidget {
  // VARIABLES =================================================================

  /// The project being previewed.
  final ProjectPreview project;

  /// The behavior when the box is tapped.
  final void Function()? onTap;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ProjectWidePreview] matching the given parameters.
  const ProjectWidePreview({super.key, required this.project, this.onTap});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(
        color: context.theme.shadowColor,
        child: SizedBox(
          width: Get.width,
          height: Get.height * 0.2,
          child: Stack(
            children: [
              // IMAGE -------------------------------------------------------------
              Positioned(
                child: CoveringNetworkImage(
                  project.preview,
                  fit: BoxFit.fitWidth,
                ),
              ),

              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(XLayout.paddingM),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // NAME ------------------------------------------------------
                      Text(
                        project.name,
                        style: context.textTheme.titleMedium,
                      ),

                      XLayout.verticalS,
                      const Divider(),
                      XLayout.verticalS,

                      // SUMMARY ---------------------------------------------------
                      Text(
                        project.summary,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// METHODS ===================================================================

}
