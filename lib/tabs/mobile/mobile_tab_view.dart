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
          allowImplicitScrolling: true,
          controller: router.pageController,
          children: const [
            MobileHome(),
            MobileProjects(),
            MobileContact(),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: navigationBarHeight,
        child: Obx(
          () => BottomNavigationBar(
            onTap: (index) => router.push(mode: AppMode.mainTabs[index]),
            currentIndex: router.modeIndex,
            items: _navigationItems,
          ),
        ),
      ),
    );
  }

  // WIDGETS ===================================================================

  /// The list of navigation items used by the [BottomNavigationBar].
  List<BottomNavigationBarItem> get _navigationItems => [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Projects",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.contact_mail),
          label: "Contact",
        ),
      ];

  /// Returns the usual [AnimatedBackground] wrapped in a [GetBuilder] in order to
  /// make the background disappear in specific situations.
  Widget _responsiveBackground(BuildContext context) {
    return GetBuilder(
      init: router,
      builder: (_) => AnimatedBackground(
        scale:
            router.mode == AppMode.projects && router.project != null ? 0 : 0.3,
      ),
    );
  }
}
