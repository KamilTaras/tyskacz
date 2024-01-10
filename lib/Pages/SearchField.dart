import 'package:flutter/material.dart';
import '../Utils/constantValues.dart';
import '../../Utils/Theme/colors.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double height;
  final double fontSize;
  final int? maxLines;

  SearchField({
    required this.controller,
    required this.hintText,
    required this.height,
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
          style: TextStyle(fontSize: widget.fontSize),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            // border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          maxLines: null,
          minLines: 1,
        ),
      ),
    );

  }
}

