import 'package:flutter/material.dart';


class InputField extends StatelessWidget {
  final String name;

  InputField({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: name,
          labelText: name,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(9)),
          ),
        ),
      ),
    );
  }
}
