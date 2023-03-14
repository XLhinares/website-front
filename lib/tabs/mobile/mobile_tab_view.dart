import "dart:async";

import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../classes/dataclass/app_mode.dart";
import "../../components/components.dart";
import "../../utils/utils.dart";
import "../../widgets/widgets.dart";
import "../tabs.dart";

/// The app body as it should
class MobileTabView extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileTabView] matching the given parameters.
  const MobileTabView({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    Timer.run(() => router.animateTo(index: router.modeIndex));

    return ScaffoldFit(
      // appBar: AppBar(
      //   title: const Text("Xeppelin"),
      // ),
      background: _responsiveBackground(context),
      body: IfAppIsReady(
        child: PageView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          controller: router.pageController,
          children: const [
            MobileHome(),
            MobileBlogs(),
            MobileProjects(),
            MobileContact(),
            MobileSettings(),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: navigationBarHeight,
        child: Obx(
          () => BottomNavigationBar(
            onTap: (index) => router.push(mode: AppMode.mainTabs[index]),
            currentIndex: router.modeIndex,
            backgroundColor: context.theme.colorScheme.background,
            unselectedItemColor: Colors.grey,
            selectedItemColor: context.theme.colorScheme.secondary,
            items: _navigationItems,
          ),
        ),
      ),
    );
  }

  // WIDGETS ===================================================================

  /// The list of navigation items used by the [BottomNavigationBar].
  List<BottomNavigationBarItem> get _navigationItems => AppMode.mainTabs
      .map((tab) => BottomNavigationBarItem(
            icon: Icon(
              tab.icon,
            ),
            label: tab.name.capitalizeFirst,
          ))
      .toList();

  /// Returns the usual [AnimatedBackground] wrapped in a [GetBuilder] in order to
  /// make the background disappear in specific situations.
  Widget _responsiveBackground(BuildContext context) {
    return GetBuilder(
      init: router,
      builder: (_) => AnimatedBackground(
        scale: _backgroundScale(),
      ),
    );
  }

  // METHODS ===================================================================

  double _backgroundScale() {
    if (router.mode == AppMode.projects && router.project != null) return 0;
    if (router.mode == AppMode.blogs && router.blog != null) return 0;
    return 0.3;
  }
}
