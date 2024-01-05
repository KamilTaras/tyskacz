import 'package:flutter/material.dart';
import 'signUp.dart';
import 'changePassword.dart';

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
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(9)),
          ),
        ),
      ),
    );
  }
}

class TextButton extends StatelessWidget {
  final String text;
  final String navigationText;
  final NavigationType navigationType;

  TextButton(
      {required this.text, required this.navigationText, required this.navigationType});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 62),
              child: Text(text),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: InkWell(
                onTap: () => _handleNavigation(context),
                child: Text(navigationText,
                    style: TextStyle(fontSize: 14, color: Colors.blue)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context) {
    switch (navigationType) {
      case NavigationType.changePassword:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChangePassword()));
        break;
      case NavigationType.signUp:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUp()));
    }
  }
}


enum NavigationType {
  changePassword,
  signUp,
}

