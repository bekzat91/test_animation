import 'package:flutter/material.dart';
import 'package:test_task/components/draw_params_inherited_widget.dart';
import 'package:test_task/constants.dart';

class OverlayDrawingWidget extends StatefulWidget {
  const OverlayDrawingWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OverlayDrawingWidget> createState() => _OverlayDrawingWidgetState();
}

class _OverlayDrawingWidgetState extends State<OverlayDrawingWidget> {
  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    final localVerticalPos =
        DrawParamsInheritedWidget.of(context).dragLocationDetails;
    final screenCutOffLine = verticalSize * kScreenPercentageCutOff;

    double firstTouchLocation =
        DrawParamsInheritedWidget.of(context).firstTouchDetails;
    double draggableVerticalPosition =
        DrawParamsInheritedWidget.of(context).dragLocationDetails;

    return Opacity(
      opacity: (screenCutOffLine / localVerticalPos).toDouble(),
      child: CustomPaint(
        painter: MyAnim(
            draggableVerticalPosition: draggableVerticalPosition,
            firstTouchLocation: firstTouchLocation),
        child: Container(),
      ),
    );
  }
}

class MyAnim extends CustomPainter {
  final double firstTouchLocation;
  final double draggableVerticalPosition;

  MyAnim(
      {required this.firstTouchLocation,
      required this.draggableVerticalPosition});
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    final paint = Paint()
      ..color = kColor
      ..style = PaintingStyle.fill;
    final path = CustomClipPath(
            firstTouchLocation: firstTouchLocation,
            draggableVerticalPosition: draggableVerticalPosition)
        .getClip(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomClipPath extends CustomClipper<Path> {
  final double firstTouchLocation;
  final double draggableVerticalPosition;

  CustomClipPath({
    required this.firstTouchLocation,
    required this.draggableVerticalPosition,
  });

  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;

    double centerOfDraggableWidget =
        height - kBottomNavBarPadding - kDraggableButtonSize / 2;

    double offsetFromMidPoint = centerOfDraggableWidget - firstTouchLocation;

    //center of drag widget
    double currentYPosition = draggableVerticalPosition + offsetFromMidPoint;

    double curveHeight = height - currentYPosition;

    double maxAllowedHeight = height * kScreenPercentageCutOff;

    double curvePoint2DefaultXOffset =
        (width / 2 - kDraggableButtonSize / 2) / 2;

    double curvePoint6DefaultXOffset = width - curvePoint2DefaultXOffset;

    double maxDistanceToSideOfDraggablePoint =
        width / 2 - kDraggableButtonSize / 2 - curvePoint2DefaultXOffset;

    double curveOffset = ((height - currentYPosition) /
        (height - maxAllowedHeight) *
        (maxDistanceToSideOfDraggablePoint));

    //Point 0 is the origin at top left corner

    //Point 1
    double point1x = 0;
    double point1y = height;

    //Point 2
    double point2x = curvePoint2DefaultXOffset + curveOffset;
    double point2y = height - curveHeight / 10;

    //Point 3
    double point3x = width / 2 - kDraggableButtonSize / 2;
    double point3y = currentYPosition - kDraggableButtonSize;

    //Point 4
    double point4x = width / 2;
    double point4y = currentYPosition - kDraggableButtonSize;

    //Point 5
    double point5x = width / 2 + kDraggableButtonSize / 2;
    double point5y = currentYPosition - kDraggableButtonSize;

    //Point 6
    double point6x = curvePoint6DefaultXOffset - curveOffset;
    double point6y = height - curveHeight / 10;

    //Point 7
    double point7x = width;
    double point7y = height;

    //Point 8
    double point8x = width;
    double point8y = 0;

    final path = Path();
    path.lineTo(
        point1x, point1y); // point 0 -> 1 top left corner to bottom left corner
    path.quadraticBezierTo(point2x, point2y, point3x, point3y); //left curve
    path.quadraticBezierTo(point4x, point4y, point5x, point5y); //middle curve
    path.quadraticBezierTo(point6x, point6y, point7x, point7y); //right curve
    path.lineTo(point8x, point8y);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
