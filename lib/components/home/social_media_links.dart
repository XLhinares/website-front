// Framework dependencies
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";

/// A widget describing what the site is about.
class SocialMediaLinks extends StatelessWidget {
  // VARIABLES =================================================================

  /// The size of the social media icons.
  final double? iconSize;
  double get _iconSize => iconSize ?? XLayout.paddingL;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [SocialMediaLinks] matching the given parameters.
  const SocialMediaLinks({
    super.key,
    this.iconSize,
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
            size: _iconSize,
          ),
          onPressed: api.openGitHub,
        ),
        // Linkedin
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.linkedin,
            size: _iconSize,
          ),
          onPressed: api.openLinkedIn,
        ),
        // Resume
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/icon_cv.svg",
            height: _iconSize,
          ),
          onPressed: api.openResume,
        ),
      ],
    );
  }

  // METHODS ===================================================================
}
