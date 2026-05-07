import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/app_route.dart";
import "../../globals.dart";
import "../../utils/extensions.dart";
import "../../widgets/body/mobile_tab.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/medias/overview_list_excerpt.dart";

/// The content of the body in the "Contact" mode.
class MobileMainPeople extends RouteTab {
  // VARIABLES =================================================================

  final RxInt _currentPage = 0.obs;

  final PageController _pageController = PageController();

  @override
  final AppRoute route = AppRoute.MAIN_PEOPLE;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileMainPeople] matching the given parameters.
  MobileMainPeople({
    super.key,
  }) {
    ever(
      _currentPage,
      (callback) => _pageController.animateToPage(
        callback,
        duration: animDurationShort,
        curve: animCurve,
      ),
    );
  }

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return MobileTab(
      route: route,
      child: Column(
        children: [
          // SELECTOR
          XContainer(
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => XButton.text(
                      "people_recommenders".tr,
                      textStyle: _currentPage.value == 0
                          ? context.bodyMediumOnSurface
                          : context.textTheme.bodyMedium,
                      color: _currentPage.value == 0
                          ? context.colors.surface
                          : Colors.transparent,
                      onTap: () => _currentPage.value = 0,
                    ),
                  ),
                ),
                XLayout.horizontalS,
                Expanded(
                  child: Obx(() => XButton.text(
                        "people_recommendeds".tr,
                        textStyle: _currentPage.value == 1
                            ? context.bodyMediumOnSurface
                            : context.textTheme.bodyMedium,
                        color: _currentPage.value == 1
                            ? context.colors.surface
                            : Colors.transparent,
                        onTap: () => _currentPage.value = 1,
                      )),
                ),
              ],
            ),
          ),
          XLayout.verticalM,
          // DISPLAY
          Expanded(
            child: GetBuilder(
                init: app.medias,
                builder: (_) {
                  return PageView(
                    controller: _pageController,
                    children: [
                      MediaListViewExcerpt(
                        medias: app.medias.recommenders,
                        onTapMedia: (media) {
                          router.goTo(AppRoute.PAGE_PEOPLE);
                          router.selectPerson(media.id);
                        },
                        onTapSeeMore: () => router.goTo(AppRoute.PAGE_PEOPLE),
                      ),
                      MediaListViewExcerpt(
                        medias: app.medias.recommendeds,
                        onTapMedia: (media) {
                          router.goTo(AppRoute.PAGE_PEOPLE);
                          router.selectPerson(media.id);
                        },
                        onTapSeeMore: () => router.goTo(AppRoute.PAGE_PEOPLE),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

// METHODS ===================================================================
}
