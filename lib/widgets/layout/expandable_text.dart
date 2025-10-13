import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../utils/exports.dart";

/// An animated widget which allows to preview and expand text.
class ExpandableText extends StatelessWidget {
  // VARIABLES =================================================================

  /// A widget to display when the card is expanded.
  final String text;

  /// The number of lines of text to display on the preview.
  final int previewLines;

  /// The [TextStyle] to use when displaying the text.
  final TextStyle? style;

  /// Whether the full text is visible or only the preview.
  final RxBool _visibility = false.obs;

  /// A function called when the card is expanded or collapsed.
  ///
  /// If the given boolean is true, then the new state is expanded;
  /// if it is false, then the card is collapsed.
  final void Function(bool)? onToggleExpansion;

  // CONSTRUCTOR ===============================================================

  /// Returns a [ExpandableText] matching the given parameters.
  ExpandableText({
    super.key,
    required this.text,
    this.previewLines = 2,
    this.style,
    this.onToggleExpansion,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _visibility.toggle(),
      child: Obx(() => AnimatedCrossFade(
            duration: animDurationShort,
            crossFadeState: _visibility.value
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              text,
              style: _getStyle(context),
              maxLines: previewLines,
              overflow: TextOverflow.fade,
            ),
            secondChild: Text(
              text,
              style: _getStyle(context),
            ),
          )),
    );
  }

  // WIDGETS ===================================================================

  TextStyle _getStyle(BuildContext context) =>
      const TextStyle().merge(context.theme.textTheme.bodyMedium).merge(style);
}
