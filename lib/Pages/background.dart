import 'package:flutter/material.dart';
import '../../Utils/Theme/colors.dart';

import 'package:flutter/material.dart';
import '../../Utils/Theme/colors.dart';

class Circle extends StatelessWidget {
  const Circle({Key? key, required this.top, required this.left, required this.diameter, required this.color, required this.opacity});
  final double top;
  final double left;
  final double diameter;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: this.top,
      left: this.left,
      child: Opacity(
        opacity: opacity,
        child: ClipOval(
          child: Container(
            width: diameter,
            height: diameter,
            color: this.color, // Change color as needed
          ),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color:mainBackgroundColor,
        ),
        Circle(top: -100, left: -25, diameter:200, color:mainGreen, opacity: 0.5),
        Circle(top: -25, left: -100, diameter:200, color:mainGreen, opacity: 0.5),
        Circle(top: 100, left: 350, diameter:75, color:mainRed, opacity: 0.8),
        Circle(top: 130, left: 250, diameter:150, color:mainRed, opacity: 0.8),

      ]

    );
  }
}
