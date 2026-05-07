import "package:flutter/material.dart";

import "button_icon.dart";

///
class ButtonMenu extends StatelessWidget {
  // VARIABLES =================================================================

  /// Optional size for the button
  final double? size;

  // CONSTRUCTOR ===============================================================

  /// Returns a [ButtonMenu] instance.
  const ButtonMenu({super.key, this.size});

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    return ButtonIcon(
      icon: Icons.menu,
      onTap: () => Scaffold.of(context).openDrawer(),
    );
  }

  // METHODS ===================================================================
}
