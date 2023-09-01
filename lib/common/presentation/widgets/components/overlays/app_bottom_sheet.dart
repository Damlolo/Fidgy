import 'package:flutter/material.dart';

import '../../../presentation.dart';

class AppBottomSheet<T> extends StatelessWidget {
  const AppBottomSheet({
    Key? key,
    required this.heading,
    required this.builder,
    this.padding = const EdgeInsets.fromLTRB(24, 0, 24, 0),
    this.isDismissable = true,
    this.dismissCallback,
  }) : super(key: key);

  final String? heading;
  final WidgetBuilder builder;
  final EdgeInsets padding;
  final bool isDismissable;
  final VoidCallback? dismissCallback;

  Future<T?> show({
    BuildContext? context,
    String? routeName,
    bool isScrollControlled = true,
  }) async {
    final ctx = context ?? AppNavigator.main.currentContext;
    final value = await showModalBottomSheet<T>(
      context: ctx,
      builder: (_) => this,
      isDismissible: isDismissable,
      isScrollControlled: isScrollControlled,
      useRootNavigator: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(ctx).size.height - 2 * kToolbarHeight,
      ),
      routeSettings: RouteSettings(
        name: routeName ?? runtimeType.toString(),
      ),
    );
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (dismissCallback != null) {
          dismissCallback!();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Row(
                children: [
                  if (heading != null)
                    Expanded(
                      child: Text(
                        heading!,
                        textAlign: TextAlign.start,
                        style: AppStyles.of(context).heading24Regular,
                      ),
                    )
                  else
                    const Spacer(),
                  if (isDismissable)
                    CloseButton(
                      onPressed: dismissCallback ?? AppNavigator.main.maybePop,
                      color: AppColors.of(context).grey5,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: SingleChildScrollView(
                padding: this.padding,
                child: builder(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
