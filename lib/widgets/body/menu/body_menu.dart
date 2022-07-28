// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:x_containers/x_containers.dart";

// Project dependencies
import "package:website_front/classes/services/app_mode.dart";
import "package:website_front/widgets/body/menu/body_title.dart";
import "package:website_front/widgets/body/menu/cookies_card.dart";
import "package:website_front/widgets/body/menu/menu_tile.dart";

/// The half of the body containing the title and the menu.
class BodyMenu extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [BodyMenu] matching the given parameters.
  const BodyMenu({Key? key}) : super(key: key);

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        // TITLE ---------------------------------------------------------------
        const BodyTitle(),

        // SEPARATOR
        XLayout.verticalM,

        Column(
          children: [

            // LINKS -----------------------------------------------------------
            ShadowContainer(
              padding: EdgeInsets.all(XLayout.paddingM),
              child: ListView(
                shrinkWrap: true,
                children: const [
                  MenuTile(mode: AppMode.home),
                  Divider(),
                  MenuTile(mode: AppMode.projects),
                  Divider(),
                  MenuTile(mode: AppMode.contact),
                ],
              ),
            ),


            const CookiesCard(),
          ],
        ),

      ],
    );
  }

  // METHODS ===================================================================

}
