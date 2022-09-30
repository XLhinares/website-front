import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/dataclass/project.dart";
import "../../widgets/widgets.dart";

/// A preview of a project.
class ProjectWidePreview extends StatelessWidget {

  // VARIABLES =================================================================

  /// The project being previewed.
  final Project project;

  /// The behavior when the box is tapped.
  final void Function()? onTap;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ProjectWidePreview] matching the given parameters.
  const ProjectWidePreview({
    super.key,
    required this.project,
    this.onTap
  });

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
                child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.black26,
                      BlendMode.darken,
                    ),
                    child: project.preview
                ),
              ),

              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(XLayout.paddingM),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      // NAME ------------------------------------------------------
                      PresetText.title(project.name,),

                      XLayout.verticalS,
                      const Divider(),
                      XLayout.verticalS,

                      // SUMMARY ---------------------------------------------------
                      PresetText.body(project.summary,),
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
