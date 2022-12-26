import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/dataclass/app_mode.dart";
import "../../../utils/globals.dart";

/// A tile displaying one menu element.
class MenuTile extends StatelessWidget {
  // VARIABLES =================================================================

  /// The mode this [MenuTile] is about.
  final AppMode mode;

  /// The behavior when this box is tapped.
  final void Function()? onTap;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MenuTile] matching the given parameters.
  const MenuTile({
    super.key,
    required this.mode,
    this.onTap,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: XLayout.paddingM),
      child: ListTile(
        title: Text(mode.name.capitalizeFirst!.tr,
            style: context.textTheme.titleMedium),
        subtitle:
            Text(mode.description.tr, style: context.textTheme.bodyMedium),
        leading: mode.icon,
        onTap: () {
          sps.goTo(mode);
          onTap?.call();
        },
      ),
    );
  }

// WIDGETS ===================================================================

}
