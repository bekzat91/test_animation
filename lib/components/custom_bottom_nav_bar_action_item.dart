import 'package:flutter/material.dart';
import 'package:test_task/components/overlay_drawing_widget.dart';
import 'package:test_task/components/draw_params_inherited_widget.dart';
import 'package:test_task/constants.dart';
import 'package:test_task/screens/actions_page.dart';

class CustomBottomNavBarActionItem extends StatefulWidget {
  const CustomBottomNavBarActionItem({
    super.key,
  });

  @override
  State<CustomBottomNavBarActionItem> createState() =>
      _CustomBottomNavBarActionItemState();
}

class _CustomBottomNavBarActionItemState
    extends State<CustomBottomNavBarActionItem>
    with SingleTickerProviderStateMixin {
  OverlayEntry? overlayEntry;

  DragUpdateDetails? localPosition;
  bool isFirstTouch = true;
  bool isOverlayMounted = false;
  DragUpdateDetails? firstTouchDetails;

  void createOverlay() {
    double screenSize = MediaQuery.of(context).size.height;
    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return DrawParamsInheritedWidget(
        dragLocationDetails: localPosition?.localPosition.dy ?? screenSize,
        firstTouchDetails: firstTouchDetails?.localPosition.dy ?? screenSize,
        child: const OverlayDrawingWidget(),
      );
    });
  }

  // Remove the OverlayEntry.
  void removeHighlightOverlay() {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  void adjustOverlay(DragUpdateDetails details) {
    if (!isOverlayMounted) {
      Overlay.of(context).insert(overlayEntry!);
      isOverlayMounted = true;
    }
    localPosition = details;
    overlayEntry?.markNeedsBuild();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Make sure to remove OverlayEntry when the widget is disposed.
    removeHighlightOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verticalSize = MediaQuery.of(context).size.height;
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Draggable(
          childWhenDragging: const SizedBox(),
          axis: Axis.vertical,
          feedbackOffset: Offset.zero,
          feedback: DraggableWidget(constraints),
          onDragStarted: () {
            createOverlay();
          },
          onDragUpdate: (details) {
            if (isFirstTouch) {
              firstTouchDetails = details;
              isFirstTouch = false;
            }
            adjustOverlay(details);
            if (details.localPosition.dy <
                verticalSize * kScreenPercentageCutOff) {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const ActionsPage();
                  },
                ),
              );
            }
          },
          onDragEnd: (details) {
            isFirstTouch = true;
            removeHighlightOverlay();
            isOverlayMounted = false;
          },
          child: const Hero(
            tag: 'button',
            child: DraggableWidget(),
          ),
        ),
      ),
    );
  }
}

class DraggableWidget extends StatelessWidget {
  final BoxConstraints? boxConstraints;

  const DraggableWidget([this.boxConstraints]);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxConstraints?.maxWidth,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(shape: BoxShape.circle, color: kColor),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: kDraggableButtonSize,
      ),
    );
  }
}
