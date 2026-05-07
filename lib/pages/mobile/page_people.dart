import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/app_route.dart";
import "../../globals.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/layout/scaffold_fit.dart";
import "../../widgets/medias/media_content.dart";
import "../../widgets/medias/media_focus.dart";
import "../../widgets/medias/mobile_header.dart";
import "../../widgets/medias/overview_list.dart";
import "../meta/if_app_is_ready.dart";
import "drawer.dart";
import "overlay.dart";

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
        drawer: CustomDrawer(),
        overlay: MobileOverlay(
          showBackButton: true,
        ),
        body: IfAppIsReady(
          child: GetBuilder(
              init: app.medias,
              builder: (_) {
                return router.person == null
                    ? MediaListView(
                        medias: app.medias.persons,
                        onTapMedia: (media) => router.selectPerson(media.id),
                      )
                    : MediaFocus(
                        media: app.medias.fetchByID(router.person!),
                        headerBuilder: (media, scrollController) =>
                            MediaMobileHeader(
                          media: media,
                          scrollController: scrollController,
                        ),
                        partsBuilder: (content) => MediaContentWidget(
                          content: content,
                          padding: EdgeInsets.all(XLayout.paddingM),
                        ),
                      );
              }),
        ),
      ),
    );
  }
}
