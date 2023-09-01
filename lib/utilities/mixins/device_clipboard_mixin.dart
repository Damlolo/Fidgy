import 'package:flutter/services.dart';

mixin DeviceClipboardMixin {
  void copyToClipboard(String text, {String? feedbackMessage}) {
    Clipboard.setData(ClipboardData(text: text));
    if (feedbackMessage != null) {
      // TODO(Majore): Open Toast
      // AppToast.success(feedbackMessage).show();
    }
  }

  Future<String?> pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }
}
