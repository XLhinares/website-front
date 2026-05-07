import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/app_route.dart";
import "../../globals.dart";
import "../../utils/extensions.dart";
import "../medias/overview_list.dart";

/// A pageview widget that shows the people according to whether they are recommenders or recommendeds.
class PeopleOverviewPage extends StatelessWidget {
  // VARIABLES =================================================================

  /// Optional padding around this widget.
  final EdgeInsets? padding;

  /// Whether there is a button to see more at the bottom of the lists.
  final bool hideSeeMore;

  final RxInt _currentPage = 0.obs;

  final PageController _pageController = PageController();

  // CONSTRUCTOR ===============================================================

  /// Returns a [PeopleOverviewPage] instance.
  PeopleOverviewPage({
    super.key,
    this.padding,
    this.hideSeeMore = false,
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
    return Column(
      children: [
        SizedBox(
          height: padding?.top,
        ),
        // SELECTOR
        XContainer(
          margin: EdgeInsets.only(
            left: padding?.left ?? 0,
            right: padding?.right ?? 0,
          ),
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
        // DISPLAY
        Expanded(
          child: GetBuilder(
              init: app.medias,
              tag: "people_overview_page",
              builder: (_) {
                final content = [
                  app.medias.recommenders,
                  app.medias.recommendeds,
                ];
                return PageView.builder(
                  controller: _pageController,
                  itemBuilder: (context, index) => MediaListView(
                    padding: EdgeInsets.only(
                      top: XLayout.paddingM,
                      left: padding?.left ?? 0,
                      right: padding?.right ?? 0,
                    ),
                    medias: content[index],
                    onTapMedia: (media) {
                      router.goTo(AppRoute.PAGE_PEOPLE);
                      router.selectPerson(media.id);
                    },
                    onTapSeeMore: hideSeeMore
                        ? null
                        : () => router.goTo(AppRoute.PAGE_PEOPLE),
                  ),
                );
              }),
        ),
      ],
    );
  }

  // METHODS ===================================================================
}
