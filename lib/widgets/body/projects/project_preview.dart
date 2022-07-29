// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

// Project dependencies
import "package:website_front/classes/dataclass/project.dart";

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
                  Text(project.name,
                    style: context.textTheme.titleMedium,
                  ),

                  XLayout.verticalS,
                  const Divider(),
                  XLayout.verticalS,

                  // SUMMARY ---------------------------------------------------
                  Expanded(
                    child: Text(project.summary,
                      style: context.textTheme.bodyMedium,
                    ),
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
