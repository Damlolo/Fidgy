import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../presentation.dart';

class AlertData {
  final String message;
  final Color borderColor;
  final Color mainColor;
  final String iconName;
  final VoidCallback? action;
  final String? actionLabel;

  AlertData(
    this.message, {
    required this.borderColor,
    required this.mainColor,
    required this.iconName,
    this.action,
    this.actionLabel,
  });
}

class AppToast {
  final String message;

  AppToast.errorToast(this.message) {
    showErrorToast(message);
  }

  AppToast.successToast(this.message) {
    showSuccessToast(message);
  }

  AppToast.warnToast(this.message) {
    showWarningToast(message);
  }

  Timer? _timerHolder;

  final BuildContext _context = AppNavigator.mainKey.currentContext!;
  final List<AlertData> _toastQueue = [];

  int get queueLength => _toastQueue.length;

  void _nextToastOnQueue() {
    if (_toastQueue.isNotEmpty) _toastBase(_toastQueue.first);
  }

  void _addToQueue(AlertData data) {
    if (_toastQueue.isEmpty || data.message != _toastQueue.last.message) {
      _toastQueue.add(data);
    }

    if (_timerHolder == null) {
      _nextToastOnQueue();
    }
  }

  void _removeToast() {
    _timerHolder?.cancel();
    _timerHolder = null;
    AppNavigator.of(_context).pop(_context);
    _toastQueue.removeAt(0);
  }

  void _toastBase(AlertData data) {
    var totalSeconds = 4;

    _timerHolder = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        _timerHolder = timer;
        totalSeconds = totalSeconds - 1;
        if (totalSeconds == 0) {
          _removeToast();
        }
      },
    );

    showGeneralDialog(
      routeSettings: const RouteSettings(name: 'Alert Toast'),
      context: AppNavigator.mainKey.currentContext!,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(
        AppNavigator.mainKey.currentState!.overlay!.context,
      ).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return WillPopScope(
          onWillPop: () {
            _removeToast();
            return Future.value(false);
          },
          child: GestureDetector(
            onTap: _removeToast,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2.5,
                  sigmaY: 2.5,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      25, kToolbarHeight + 48.0, 25, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: data.mainColor,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            width: 8.0,
                            color: data.borderColor,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 16.0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //   height: 30.0,
                                    //   width: 30.0,
                                    //   child: AppUtil.svgPicture(data.iconName),
                                    // ),
                                    // const SizedBox(width: 16.0),
                                    Expanded(
                                      child: Text(
                                        data.message,
                                        style: AppStyles.of(_context)
                                            .body16Bold
                                            .copyWith(
                                              color:
                                                  AppColors.of(_context).grey5,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //!
                            // if (data.action != null && data.actionLabel != null)
                            //   InkResponse(
                            //     onTap: data.action,
                            //     child: Container(
                            //       alignment: Alignment.center,
                            //       margin: const EdgeInsets.only(left: 8),
                            //       padding: const EdgeInsets.symmetric(
                            //         horizontal: 12,
                            //         vertical: 6,
                            //       ),
                            //       decoration: BoxDecoration(
                            //         color: data.color,
                            //       ),
                            //       child: Text(
                            //         '${data.actionLabel}',
                            //         style: const TextStyle(
                            //           fontWeight: FontWeight.w500,
                            //           fontSize: 14,
                            //           color: Color(0xFF010F25),
                            //         ),
                            //       ),
                            //     ),
                            //   )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) => _nextToastOnQueue());
  }

  void showErrorToast(
    String message, {
    VoidCallback? action,
    String? actionLabel,
  }) {
    _addToQueue(
      AlertData(
        message.isEmpty ? 'Something went wrong, try again.' : message,
        action: action,
        actionLabel: actionLabel,
        iconName: 'failed_toast_icon',
        borderColor: AppColors.of(_context).attitudeErrorMain,
        mainColor: AppColors.of(_context).attitudeErrorLight,
      ),
    );
  }

  void showSuccessToast(
    String message, {
    VoidCallback? action,
    String? actionLabel,
  }) {
    _addToQueue(
      AlertData(
        message,
        borderColor: AppColors.of(_context).attitudeSuccessMain,
        mainColor: AppColors.of(_context).attitudeSuccessLight,
        action: action,
        actionLabel: actionLabel,
        iconName: 'success_toast_icon',
      ),
    );
  }

  void showWarningToast(
    String message, {
    VoidCallback? action,
    String? actionLabel,
  }) {
    _addToQueue(
      AlertData(
        message,
        action: action,
        actionLabel: actionLabel,
        iconName: 'warning_toast_icon',
        borderColor: AppColors.of(_context).attitudeWarningMain,
        mainColor: AppColors.of(_context).attitudeWarningLight,
      ),
    );
  }
}
