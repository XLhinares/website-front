// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:website_front/tabs/body.dart";
import "package:website_front/widgets/interactables/buttons.dart";

// Project dependencies

/// The one-page style website that the user navigates on.
class Home extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [Home] matching the given parameters.
  const Home({Key? key}) : super(key: key);

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: Body()),
          Positioned.fill(bottom: 0, left: 0, child: Buttons(),),
        ],
      ),
    );
  }

// METHODS ===================================================================



}
