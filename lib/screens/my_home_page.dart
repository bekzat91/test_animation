import 'package:flutter/material.dart';
import 'package:test_task/components/custom_bottom_nav_bar_action_item.dart';
import 'package:test_task/components/custom_bottom_nav_bar_item.dart';
import 'package:test_task/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      body: Center(
        child: Text(
          'Events',
          style: TextStyle(
            fontSize: 36,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(bottom: kBottomNavBarPadding),
      child: const Row(
        children: [
          CustomBottomNavBarItem(
            icon: Icon(Icons.folder_copy),
          ),
          CustomBottomNavBarItem(
            icon: Icon(Icons.search),
          ),
          CustomBottomNavBarActionItem(),
          CustomBottomNavBarItem(
            icon: Icon(Icons.bolt),
          ),
          CustomBottomNavBarItem(
            icon: Icon(Icons.menu),
          ),
        ],
      ),
    );
  }
}
