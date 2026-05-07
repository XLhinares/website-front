import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../contact/contact_title.dart";
import "people_overview_list.dart";

///
class PersonOverviewDesktop extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [PersonOverviewList] instance.
  const PersonOverviewDesktop({
    super.key,
  });

  // BUILD =====================================================================
  @override
  Widget build(BuildContext context) {
    // Layout builder lets us compute the width of cards so a exact number of them fit in the display.
    return GetBuilder(
        init: app.medias,
        builder: (_) {
          return ListView(
            padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            shrinkWrap: true,
            children: [
              // PRESENTATION --------------------------------------------------------

              const PeopleTitle(),
              XLayout.verticalL,

              // FORM ----------------------------------------------------------------
              PersonOverviewList(
                title: "people_recommenders".tr,
                persons: app.medias.recommenders,
              ),
              XLayout.verticalM,
              PersonOverviewList(
                title: "people_recommendeds".tr,
                persons: app.medias.recommendeds,
              ),
            ],
          );
        });
  }

  // METHODS ===================================================================
}
