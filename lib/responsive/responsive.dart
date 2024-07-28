import 'package:flutter/material.dart';
import 'package:new_project/responsive/mobilescreen.dart';
import 'package:new_project/responsive/webscreen.dart';

class Responsive extends StatefulWidget {
  final MobileScreen mobileScreen;
  final WebScreen webScreen;
  const Responsive(
      {super.key, required this.mobileScreen, required this.webScreen});

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  @override
  Widget build(BuildContext context) {
    // to get screen width
    //1- MediaQuery.of(context).size.width;
    //2- use LayoutBuilder to get the width of the screen
    return LayoutBuilder(
      builder: (BuildContext, BoxConstraints) {
        if (BoxConstraints.maxWidth > 600) {
          return widget.webScreen;
        } else {
          return widget.mobileScreen;
        }
      },
    );
  }
}
