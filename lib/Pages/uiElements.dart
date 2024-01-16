import 'package:flutter/material.dart';
import '../../Utils/Theme/colors.dart';

import 'package:flutter/material.dart';
import '../../Utils/Theme/colors.dart';
import '../../Utils/constantValues.dart';


// Background, CreateTitle, MessageIsEmpty


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
          Positioned(
                top: 150,
                right: -20,
                  child: Container(
                    height:250,
                    width: 250,
                    child: Image.asset(
                      'assets/photos/domek.png', // Replace with your image asset path
                      fit: BoxFit.cover, // Adjust the fit as needed
                    ),
                  ),
              ),



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

class CreateTitle extends StatelessWidget {
  const  CreateTitle({super.key, required this.screenWidth, required this.title});
  final double screenWidth;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Constant.titleHeight,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children:[
              Divider(
                indent: 70,
                endIndent:70,
                  height: 10,
                  thickness: 2,
                  color: Constant.mainRedColor, // Choose the color you prefer
                ),
              Text(title, style:  TextStyle(fontFamily: 'MainFont', fontSize: 50, color: Colors.grey[900])),

              Container(
                width: screenWidth*0.9,
                child: Divider(
                  height: 20,
                  thickness: 2,
                  color: Constant.mainGreenColor, // Choose the color you prefer
                ),
              ),
            ]
        )

    );
  }
}

class MessageIsEmpty extends StatelessWidget {
  const MessageIsEmpty({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 70,
            decoration: BoxDecoration(
              color: Constant.mainRedColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 20, fontFamily: 'MainFont', color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )),
        SizedBox(height: 10,)
      ],
    );
  }
}
