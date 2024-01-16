import 'package:flutter/material.dart';
import '../../Utils/Theme/colors.dart';


class InputField extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  InputField({super.key, required this.name, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: name,
          labelText: name,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: mainGreen),
            borderRadius: BorderRadius.all(Radius.circular(9)),
          ),
        ),
        controller: controller,
      ),
    );
  }
}
