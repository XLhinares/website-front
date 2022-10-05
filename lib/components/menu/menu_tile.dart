import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/dataclass/app_mode.dart";
import "../../../utils/globals.dart";
import "../../widgets/widgets.dart";

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
        title: PresetText.headline(mode.name.capitalizeFirst!.tr),
        subtitle: PresetText.body(mode.description.tr),
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
