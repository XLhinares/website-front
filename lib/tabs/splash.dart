// Flutter dependencies
import "dart:async";
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";
import "package:website_front/utils/globals.dart";

// Project dependencies

/// The screen at the beginning of the app that loads the required components.
///
/// At the end of the splash screen, all the critical initialization tasks can
/// be assumed to be completed.
class Splash extends StatelessWidget {

// VARIABLES =================================================================

  /// The opacity of the contents.
  final RxDouble opacity = RxDouble(1);

  /// The time it takes for the contents to disappear at the end of the loading.
  final Duration fadeOutTime = animationDuration;

// CONSTRUCTOR ===============================================================

  /// Returns an instance of [SplashScreen] matching the given parameters.
  Splash({super.key}) {
// Start checking if the requirement are loaded as soon as possible.
    Timer.run(checkIfLoaded);
  }

// BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() =>
            AnimatedOpacity(
              opacity: opacity.value,
              duration: fadeOutTime,
              child: ShadowContainer(
                margin: EdgeInsets.all(XLayout.paddingM),
                height: Get.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Préparation de l'appli.",
                      style: context.textTheme.bodyMedium,
                    ),
                    XLayout.verticalM,
                    CircularProgressIndicator(
                      color: context.theme.colorScheme.secondary,
                    ),
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }

  // METHODS ===================================================================

  /// Check whether the requirements to go to the next screen are loaded.
  ///
  /// If they are not, a new check is scheduled after 50ms.
  void checkIfLoaded () {
    // Guard clause if not loaded.
    if (!settings.loaded.value
    ) {
      Timer(const Duration(milliseconds: 50), checkIfLoaded);
      return;
    }

    // Go to next screen
    opacity.value = 0;
    Timer(fadeOutTime, () => Get.offNamed("/home"));

  }
}