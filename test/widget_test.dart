// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// Project dependencies
import "integration_tests/main.dart";
import "unit_tests/main.dart";
import "widget_tests/main.dart";

void main() {

  runAllUnitTest();
  runAllWidgetTests();
  runAllIntegrationTests();

}
