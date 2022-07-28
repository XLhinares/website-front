// Package dependencies
import "package:get/get.dart";

// Project dependencies
import "package:website_front/classes/dataclass/project.dart";

/// A list of projects that's meant to be fetched online in the future.
List<Project> projects = [
  // SWALLO
  Project(
    name: "Swallo",
    previewPath: "background/whale.webp",
    imagePath: "background/skyrider.png",
    summary: "A party app, blablabla...",
    description: "lorem ipsum".tr,
  ),
  // ZEOWE
  Project(
    name: "Zeowe",
    previewPath: "background/whale.webp",
    imagePath: "background/skyrider.png",
    summary: "An app to help you manage your money.",
    description: "lorem ipsum".tr,
  ),
  // ZEQUAS
  Project(
    name: "Zequas",
    previewPath: "background/whale.webp",
    imagePath: "background/skyrider.png",
    summary: "An app meant to help students learn maths from their phones.",
    description: "lorem ipsum".tr,
  ),
  // XCONTAINERS
  Project(
    name: "XContainers",
    previewPath: "background/whale.webp",
    imagePath: "background/skyrider.png",
    summary: "A Flutter package to uniformize my box designs.",
    description: "lorem ipsum".tr,
  ),
];