// Framework dependencies
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";

/// A widget describing what the site is about.
class SocialMediaLinks extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [SocialMediaLinks] matching the given parameters.
  const SocialMediaLinks({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Github
        IconButton(
            icon: FaIcon(
              FontAwesomeIcons.github,
              size: XLayout.paddingL,
            ),
            onPressed: () => api.launch("https://github.com/XLhinares/")),
        // Linkedin
        IconButton(
            icon: FaIcon(
              FontAwesomeIcons.linkedin,
              size: XLayout.paddingL,
            ),
            onPressed: () =>
                api.launch("https://www.linkedin.com/in/xavier-lhinares/")),
        // Resume
        IconButton(
            icon: SvgPicture.asset(
              "assets/icons/icon_cv.svg",
              height: XLayout.paddingL,
            ),
            onPressed: () => api.launch(
                "https://assets.xeppelin.org/other/XAVIER-LHINARES-CV-en.pdf")),
      ],
    );
  }

  // METHODS ===================================================================
}
