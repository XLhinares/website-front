import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/extensions.dart";

/// A general button to display media info such as website or status.
class MediaButton extends StatelessWidget {
  // VARIABLES =================================================================

  /// The icon to show
  final Widget icon;

  /// A message to show when the button is hovered.
  final String tooltipMessage;

  /// Whether the button should be replaced by an empty `SizedBox` when the github is null.
  final bool Function()? hideCondition;

  /// Whether to show only the button icon (and NOT the button box)
  final bool iconOnly;

  /// An optional margin to put around the button.
  final EdgeInsets? margin;

  /// The behavior when the button is tapped.
  final void Function()? onTap;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaButton] instance.
  const MediaButton({
    super.key,
    required this.icon,
    required this.tooltipMessage,
    this.margin,
    this.iconOnly = false,
    this.hideCondition,
    this.onTap,
  });

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    if (hideCondition?.call() ?? false) return SizedBox();

    return Tooltip(
      message: tooltipMessage.tr,
      child: iconOnly
          ? GestureDetector(
              onTap: onTap,
              child: Padding(
                  padding: XLayout.edgeInsetsAllXS +
                      (margin ?? EdgeInsets.only(left: XLayout.paddingS)),
                  child: icon),
            )
          : XButton(
              margin: margin ?? EdgeInsets.only(left: XLayout.paddingS),
              padding: XLayout.edgeInsetsAllXS,
              width: XLayout.paddingL,
              height: XLayout.paddingL,
              color: context.colors.secondary,
              onTap: onTap,
              child: icon,
            ),
    );
  }

  // METHODS ===================================================================
}
