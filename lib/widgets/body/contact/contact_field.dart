// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import 'package:x_containers/settings/x_layout.dart';

/// A single field for the contact form.
class ContactField extends StatelessWidget {

  // VARIABLES =================================================================

  /// The title of the field.
  final String title;

  /// The text controller of the field.
  final TextEditingController controller;

  /// An optional validator to check whether the text is legal.
  final String? Function(String?)? validator;

  /// The maximum number of lines allowed in the field.
  ///
  /// It impacts the height of the box.
  final int maxLines;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ContactField] matching the given parameters.
  const ContactField({
    super.key,
    required this.title,
    required this.controller,
    this.validator,
    this.maxLines = 1,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      style: context.textTheme.bodyMedium,
      decoration: const InputDecoration().copyWith(
        hintText: title,
        contentPadding: EdgeInsets.all(XLayout.paddingM),
      ),
    );
  }

  // METHODS ===================================================================

}
