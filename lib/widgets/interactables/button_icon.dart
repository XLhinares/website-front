import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/extensions.dart";

///
class ButtonIcon extends StatelessWidget {
  // VARIABLES =================================================================

  final IconData icon;

  final void Function() onTap;

  /// Optional size for the button
  final double? size;

  // CONSTRUCTOR ===============================================================

  /// Returns a [ButtonIcon] instance.
  const ButtonIcon(
      {super.key, this.size, required this.icon, required this.onTap});

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    return XButton(
      width: size ?? XLayout.paddingL * 1.5,
      height: size ?? XLayout.paddingL * 1.5,
      borderDecoration: Border.all(
        color: context.theme.colorScheme.onSurface,
        width: 2,
      ),
      color: context.theme.colorScheme.surface,
      onTap: onTap,
      child: Icon(
        icon,
        color: context.colors.onSurface,
      ),
    );
  }

  // METHODS ===================================================================
}
