import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "cookies_card.dart";
import "desktop_title.dart";
import "menu_list.dart";

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

            // // The test was a way to verify access to the internet.
            // // It doesn't appear any more on the website because users don't understand what it's for.
            // XLayout.verticalM,
            // const TestCard(),
          ],
        ),
      ],
    );
  }

// METHODS ===================================================================
}
