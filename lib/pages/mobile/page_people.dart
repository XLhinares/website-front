import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/app_route.dart";
import "../../globals.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/layout/mobile_appbar.dart";
import "../../widgets/layout/scaffold_fit.dart";
import "../../widgets/medias/media_content.dart";
import "../../widgets/medias/media_focus.dart";
import "../../widgets/medias/mobile_header.dart";
import "../../widgets/people/people_overview_page.dart";
import "../meta/if_app_is_ready.dart";
import "drawer.dart";

/// The full "people" tab adapted for mobile.
class MobilePagePeople extends RouteTab {
  // VARIABLES =================================================================

  @override
  final AppRoute route = AppRoute.PAGE_PEOPLE;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobilePagePeople] matching the given parameters.
  MobilePagePeople({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: router,
      builder: (controller) => ScaffoldFit(
        overlay: MobileAppbar(title: "tab_people".tr),
        drawer: CustomDrawer(),
        body: IfAppIsReady(
          child: router.person == null
              ? PeopleOverviewPage(
                  padding: EdgeInsets.only(
                    top: XLayout.paddingL * 2.5, // Account for appbar
                    left: XLayout.paddingM,
                    right: XLayout.paddingM,
                  ),
                  hideSeeMore: true,
                )
              : MediaFocus(
                  media: app.medias.fetchByID(router.person!),
                  headerBuilder: (media, scrollController) => MediaMobileHeader(
                    media: media,
                    scrollController: scrollController,
                  ),
                  partsBuilder: (content) => MediaContentWidget(
                    content: content,
                    padding: EdgeInsets.all(XLayout.paddingM),
                  ),
                ),
        ),
      ),
    );
  }
}
