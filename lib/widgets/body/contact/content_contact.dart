// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

// Project dependencies
import "package:website_front/widgets/body/contact/contact_field.dart";

/// The content of the body in the "Projects" mode.
class BodyContentsContact extends StatelessWidget {

  // VARIABLES =================================================================

  /// The controller managing the "name" field.
  final TextEditingController controllerName = TextEditingController();

  /// The controller managing the "email" field.
  final TextEditingController controllerEmail = TextEditingController();

  /// The controller managing the "subject" field.
  final TextEditingController controllerSubject = TextEditingController();

  /// The controller managing the "contents" field.
  final TextEditingController controllerContents = TextEditingController();

  // CONSTRUCTOR ===============================================================

  /// Returns a [BodyContentsContact] matching the given parameters.
  BodyContentsContact({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // PRESENTATION --------------------------------------------------------
        XContainer(
          child: Text(
              "Contact form explanation".tr
          ),
        ),

        XLayout.verticalM,

        // FORM ----------------------------------------------------------------
        Expanded(
          child: XContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ContactField(
                  title: "Name",
                  controller: controllerName,
                ),

                XLayout.verticalM,

                ContactField(
                  title: "E-Mail address",
                  controller: controllerEmail,
                ),

                XLayout.verticalM,

                ContactField(
                  title: "Subject",
                  controller: controllerSubject,
                ),

                XLayout.verticalM,

                Expanded(
                  child: ContactField(
                    title: "Details",
                    maxLines: 10,
                    controller: controllerContents,
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }

// METHODS ===================================================================

}
