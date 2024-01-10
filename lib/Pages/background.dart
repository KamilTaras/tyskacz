import 'package:flutter/material.dart';
import '../../Utils/Theme/colors.dart';

import 'package:flutter/material.dart';
import '../../Utils/Theme/colors.dart';
import '../../Utils/constantValues.dart';

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

class Pic extends StatelessWidget {
  const Pic({Key? key, this.top, this.left, this.right, this.bottom, required this.path});

  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        child: Image.asset(
          path, // Replace with your image asset path
          fit: BoxFit.cover, // Adjust the fit as needed
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
        Circle(top: 100, left: 350, diameter:75, color:Constant.mainRedColor, opacity: 0.6),
        Circle(top: 130, left: 250, diameter:150, color:Constant.mainRedColor, opacity: 0.6),

      ]

    );
  }
}

class BackgroundSignUp extends StatelessWidget {
  const BackgroundSignUp({super.key});

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
          Circle(top: 600, left: -60, diameter:140, color:Constant.mainRedColor, opacity: 0.6),
          Pic(top:10, right:-20, path:'assets/photos/domek.png')
        ]

    );
  }
}

class BackgroundSuitcase extends StatelessWidget {
  const BackgroundSuitcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Positioned(
          bottom: 40,
          left: 20,
            child: Container(
              child: Image.asset(
                'assets/photos/suitcase.png', // Replace with your image asset path
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
        ),
      ],
    );
  }

}


class BackgroundAutko extends StatelessWidget {
  const BackgroundAutko({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Positioned(
          top: 200,
          child: ClipOval(
            child: Image.asset(
              'assets/photos/autko.png', // Replace with your image asset path
              fit: BoxFit.cover, // Adjust the fit as needed
            ),
          ),
        ),
      ],
    );
  }

}
