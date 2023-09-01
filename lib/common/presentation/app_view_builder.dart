import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'app_view_model.dart';

class AppViewBuilder<T extends AppViewModel> extends StatefulWidget {
  const AppViewBuilder({
    Key? key,
    required this.model,
    required this.builder,
    this.child,
    this.initState,
    this.postFrameCallback,
  }) : super(key: key);

  final T model;
  final Widget? child;
  final void Function(T vm)? initState;
  final void Function(T vm)? postFrameCallback;
  final Widget Function(T vm, Widget? child) builder;

  @override
  AppViewBuilderState<T> createState() => AppViewBuilderState<T>();
}

class AppViewBuilderState<T extends AppViewModel>
    extends State<AppViewBuilder<T>> {
  late T model;

  @override
  void initState() {
    model = widget.model;

    final initState = widget.initState;
    if (initState != null) {
      try {
        initState(model);
      } catch (e, t) {
        Logger(widget.runtimeType.toString())
            .severe('Error in initState of AppViewBuilderState', e, t);
      }
    }

    final callback = widget.postFrameCallback;
    if (callback != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          callback(model);
        } catch (e, t) {
          Logger(widget.runtimeType.toString()).severe(
              'Error in postFrameCallback of AppViewBuilderState', e, t);
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: (BuildContext context, T value, Widget? child) {
          try {
            return widget.builder(value, child);
          } catch (e) {
            debugPrint('Error in builder of AppViewBuilder: $e');
            return Container();
          }
        },
        child: widget.child,
      ),
    );
  }
}
