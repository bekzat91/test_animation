import 'package:flutter/material.dart';

class DrawParamsInheritedWidget extends InheritedWidget {
  final Widget child;

  final double firstTouchDetails;
  final double dragLocationDetails;

  const DrawParamsInheritedWidget(
      {Key? key,
      required this.child,
      required this.firstTouchDetails,
      required this.dragLocationDetails})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static DrawParamsInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DrawParamsInheritedWidget>()!;
  }
}
