import 'package:flutter/material.dart';

import 'custom_app_bar.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.body,
    this.footer,
  });

  final String title;
  final String? subtitle;
  final Widget body;
  final Widget? footer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: kToolbarHeight + 16,
        ),
        child: Column(
          children: [
            CustomAppBar(title: title, subtitle: subtitle),
            const SizedBox(height: 8),
            Flexible(
              child: body,
            ),
          ],
        ),
      ),
      bottomSheet: footer == null
          ? null
          : Padding(
              padding: EdgeInsets.fromLTRB(24, 8, 24,
                  MediaQuery.of(context).viewInsets.bottom > 40 ? 8 : 48),
              child: footer,
            ),
    );
  }
}
