import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/tools.dart";

/// A widget that lets the user select a value through "left/right" interactions.
class LRSelector extends StatelessWidget {
  // VARIABLES =================================================================

  /// The controller of the text to display in the middle of the selector.
  final Rx controller;

  /// The behavior to be executed when clicking of the left button.
  final void Function()? leftBehavior;

  /// The behavior to be executed when clicking of the right button.
  final void Function()? rightBehavior;

  /// The horizontal extent of this widget.
  final double? width;

  // CONSTRUCTOR ===============================================================

  /// A widget that lets the user select a value through "left/right" interactions.
  const LRSelector({
    super.key,
    required this.controller,
    this.leftBehavior,
    this.rightBehavior,
    this.width,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if ((details.primaryVelocity ?? 0) > 10) {
          leftBehavior?.call();
        } else if ((details.primaryVelocity ?? 0) < -10) {
          rightBehavior?.call();
        }
      },
      child: XContainer(
        color: context.theme.colorScheme.surface,
        padding: EdgeInsets.symmetric(
          vertical: XLayout.paddingS,
          horizontal: XLayout.paddingXS,
        ),
        width: width,
        child: Row(
          children: [
            GestureDetector(
              onTap: leftBehavior,
              child: Icon(Icons.chevron_left, color: context.colors.onSurface),
            ),
            Expanded(
              child: Center(
                child: Obx(
                  () => AutoSizeText(
                    controller.value.toString().capitalizeFirst!,
                    minFontSize: 8,
                    maxLines: 1,
                    style: context.bodyMediumOnSurface,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: rightBehavior,
              child: Icon(Icons.chevron_right, color: context.colors.onSurface),
            ),
          ],
        ),
      ),
    );
  }

  // METHODS ===================================================================
}
