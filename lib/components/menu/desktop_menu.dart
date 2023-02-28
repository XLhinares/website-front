import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "menu.dart";

/// The half of the body containing the title and the menu.
class BodyMenu extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [BodyMenu] matching the given parameters.
  const BodyMenu({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        // TITLE ---------------------------------------------------------------
        const BodyTitle(),

        // SEPARATOR
        XLayout.verticalM,

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // LINKS -----------------------------------------------------------
            XContainer(
              padding: EdgeInsets.all(XLayout.paddingM),
              child: MenuList(),
            ),

            const CookiesCard(),

            XLayout.verticalM,

            const TestCard(),
          ],
        ),
      ],
    );
  }

// METHODS ===================================================================
}
