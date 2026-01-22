// Flutter dependencies
import "package:flutter_test/flutter_test.dart";

// Project dependencies
import "package:website_front/globals.dart";

void settingsTest() => test("[Settings] loads in less than 1s.", () async {
      // Build our app and trigger a frame.
      // await pumpApp(tester);

      expect(app.cookies.isLoaded.value, false);
      // Wait 2 seconds
      await Future.delayed(const Duration(milliseconds: 1000));

      expect(app.cookies.isLoaded.value, true);
    });
