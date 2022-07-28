// Flutter dependencies
import "package:flutter/material.dart";

/// A dataclass
class Project {

  // VARIABLES =================================================================

  /// The name of the project.
  final String name;

  /// The path to access a preview image of the project.
  ///
  /// The image should be in 16:9 ratio and webp format.
  final String _preview;

  /// The path to access an actual image of the project.
  ///
  /// The image should be in 4:1 ratio and webp format.
  final String _image;

  /// A short description of the project.
  final String summary;

  /// A full description of the project.
  final String description;

  // GETTERS ===================================================================

  /// A preview image of the project.
  Widget get preview => Image.asset(_preview,
    fit: BoxFit.fitHeight,
  );

  /// The actual image of the project
  Widget get image => Image.asset(_image,
    fit: BoxFit.cover,
  );

  // CONSTRUCTOR ===============================================================

  /// Returns a [Project] matching the given parameters.
  const Project({
    required this.name,
    required String previewPath,
    required String imagePath,
    required this.summary,
    required this.description,
  }) : _preview = previewPath,
        _image = imagePath;

  /// Returns a [Project] matching the given json element.
  factory Project.fromJson(Map<String, dynamic> json) => Project(
    name: json["name"],
    previewPath: json["previewPath"],
    imagePath: json["imagePath"],
    summary: json["summary"],
    description: json["description"],
  );

}