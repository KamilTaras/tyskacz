import 'package:flutter/material.dart';
import '../Utils/constantValues.dart';
import '../../Utils/Theme/colors.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double height = 60;
  final double fontSize;
  final int? maxLines;

  SearchField({
    required this.controller,
    required this.hintText,
    required this.fontSize,
    this.maxLines = 1,
  });

  @override
  _SearchField createState() => _SearchField();
}

class _SearchField extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0, // Adjust the elevation as needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0), // Adjust the border radius as needed
      ),
      color: mainGreen[400],
      child: Container(
        height: widget.height,
        child: TextField(
          controller: widget.controller,
          style: TextStyle(
            fontSize: widget.fontSize,
            color: Colors.white, // Set text color to white
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontFamily: 'MainFont'), // Set hint text color to white with opacity
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          maxLines: null,
          minLines: 1,
        ),
      ),
    );
  }
}
