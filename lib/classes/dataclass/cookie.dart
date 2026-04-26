import "dart:async";

import "package:get/get.dart";
import "package:get_storage/get_storage.dart";

import "../../globals.dart";
import "../../utils/extensions.dart";

/// Represents a single cookie.
///
/// Contains a single piece of information (ex: locale, theme, etc.).
class Cookie<T> extends GetxController {
  /// The name of the cookie.
  ///
  /// This is also the identifier of the info with [GetStorage].
  final String name;

  /// The value of the cookie.
  ///
  /// If it has not been loaded or cannot be loaded, then it will return [defaultValue].
  final Rx<T> _value;

  /// The value of the cookie.
  ///
  /// In order to simplify syntax (i.e. not write "cookie.value.value"
  /// everywhere), it doesn't have Rx properties, however the class extends
  /// [GetxController] and is updated whenever the value of the cookie changes.
  T get value => _value.value;

  /// A setter for the value of the cookie.
  set value(T v) => _value.value = v;

  /// The rx held value in the cookie.
  ///
  /// In general, it is easier to use the [value] getter/setter pair.
  /// However, in some situations, this causes the cookie to not refresh (for
  /// instance, if the cookie holds a list and we use [value.add(...)]).
  Rx<T> get rx => _value;

  /// The fallback value of the cookie.
  final T defaultValue;

  /// Any extra behavior that should be run when updating the value of the cookie.
  ///
  /// For instance, updating the theme should call `app.theme.changeTheme`.
  FutureOr<void> Function(T value)? onSave;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [Cookie] matching the given params.
  Cookie(this.name, {required this.defaultValue, this.onSave})
      : _value = Rx<T>(defaultValue);

  /// Loads the value of the cookie from the [GetStorage].
  Future<void> load(GetStorage storage) async {
    final dynamic storedValue = storage.read(name);
    dlog("[$name] Stored value: $storedValue (${storedValue.runtimeType})");
    if (storedValue == null) {
      value = defaultValue;
    } else if (defaultValue is List) {
      value = _castList(storedValue) as T;
    } else {
      value = storedValue as T;
    }
    ever<T>(_value, (v) => _save(storage));
    ever<T>(_value, (v) => update());
    await _save(storage);
  }

  Future<void> _save(GetStorage storage) async {
    dlog("Updating $name to: ${_value.value.toString()}");
    await onSave?.call(_value.value);
    if (app.cookies.allowCookies.value) {
      await storage.write(name, _value.value);
    }
  }

  /// Helper to convert dynamic lists to the specific type T.
  ///
  /// This is used because GetStorage stores values through json,
  /// so reading a [List] value returns a [List<dynamic>] which struggle to be
  /// cast back to its original type.
  dynamic _castList(List<dynamic> list) {
    if (defaultValue is List<int>) return List<int>.from(list);
    if (defaultValue is List<double>) return List<double>.from(list);
    if (defaultValue is List<String>) return List<String>.from(list);
    // Add other types if necessary
    return list;
  }

  /// Force the cookie to be refreshed.
  ///
  /// This ensures the new value is saved and all observing widgets are updated.
  /// THis function is not necessary with most cookies; however, cookies dealing
  /// with lists need to be refreshed to notices changes to the content of the
  /// list.
  void manualRefresh() => _value.refresh();
}
