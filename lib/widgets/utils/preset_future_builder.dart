import "package:flutter/material.dart";

/// A [FutureBuilder] with a preset strategy to handle common errors.
///
/// It provides the builder directly with the data (and not the snapshot).
class PresetFutureBuilder<T> extends StatelessWidget {

  // VARIABLES =================================================================

  /// The asynchronous computation to which this builder is currently connected, possibly null.
  ///
  /// If no future has yet completed, including in the case where future is null, the data provided to the builder will be set to initialData.
  final Future<T>? future;

  /// The build strategy currently used by this builder.
  ///
  /// It is provided with the data returned by the [future].
  final Widget Function(BuildContext, T?) builder;

  /// A customizable loading widget.
  ///
  /// Defaults to a centered [CircularProgressIndicator].
  final Widget? loadingWidget;

  /// A customizable error widget.
  ///
  /// Defaults to a "An error occurred" message.
  final Widget? errorWidget;

  // GETTERS ===================================================================

  /// The actual widget displayed on loading.
  Widget get _loadingWidget => loadingWidget ?? const Center(
    child: CircularProgressIndicator(),
  );

  /// The actual widget displayed on error.
  Widget get _errorWidget => errorWidget ?? const Center(
    child: Text("An error occurred."),
  );

  // CONSTRUCTOR ===============================================================

  /// Returns a [PresetFutureBuilder] matching the given parameters.
  const PresetFutureBuilder ({
    super.key,
    this.future,
    required this.builder,
    this.loadingWidget,
    this.errorWidget,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (_, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) return _loadingWidget;
        if (snapshot.connectionState == ConnectionState.active) return _loadingWidget;
        if (snapshot.hasError) return _errorWidget;
        if (!snapshot.hasData) return _errorWidget;

        return builder(context, snapshot.data);
      },
    );
  }

// WIDGETS ===================================================================

}