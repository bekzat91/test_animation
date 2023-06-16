import 'package:flutter/material.dart';

class CustomBottomNavBarItem extends StatelessWidget {
  const CustomBottomNavBarItem({
    super.key,
    required this.icon,
  });

  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: icon,
      ),
    );
  }
}
