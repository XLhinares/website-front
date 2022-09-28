// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

// Project dependencies
import "../../../classes/dataclass/project.dart";
import "../../text/text.dart";

/// A preview of a project.
class ProjectPreview extends StatelessWidget {

  // VARIABLES =================================================================

  /// The project being previewed.
  final Project project;

  /// The behavior when the box is tapped.
  final void Function()? onTap;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ProjectPreview] matching the given parameters.
  const ProjectPreview({
    super.key,
    required this.project,
    this.onTap
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XInkContainer(
      height: Get.height * 0.25,
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        children: [

          // IMAGE -------------------------------------------------------------
          ColoredBox(
            color: context.theme.shadowColor,
            child: ClipRect(
              clipBehavior: Clip.hardEdge,
              child: AspectRatio(
                aspectRatio: 16/9,
                child: SizedBox(
                  width: double.infinity,
                  child: project.preview,
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(XLayout.paddingM),
              child: Column(
                children: [

                  // NAME ------------------------------------------------------
                  PresetText.title(project.name,),

                  XLayout.verticalS,
                  const Divider(),
                  XLayout.verticalS,

                  // SUMMARY ---------------------------------------------------
                  Expanded(
                    child: PresetText.body(project.summary,),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// METHODS ===================================================================

}
