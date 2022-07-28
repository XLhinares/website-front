// Flutter dependencies
import "package:flutter/material.dart";

/// A single field for the contact form.
class ContactField extends StatelessWidget {

  // VARIABLES =================================================================

  /// The title of the field.
  final String title;

  /// The text controller of the field.
  final TextEditingController controller;

  /// An optional validator to check whether the text is legal.
  final String? Function(String?)? validator;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ContactField] matching the given parameters.
  const ContactField({
    super.key,
    required this.title,
    required this.controller,
    this.validator,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: const InputDecoration().copyWith(
        hintText: title,
      ),
    );
  }

  // METHODS ===================================================================

}
