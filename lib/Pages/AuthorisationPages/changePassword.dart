import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../NavBarPages/navBar.dart';
import 'widgetClasses.dart';
import '../background.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  Map userData = {};
  String info = 'Enter a code from our e-mail and your new password below';
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final double buttonWidth = screenWidth * 0.9;
    final double buttonHeight = screenHeight * 0.08;
    final double spaceUnderTitle = screenHeight * 0.05;

    return Stack(
        children: [
          Background(),
          Scaffold(
              appBar: AppBar(
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CreateTitle(title: 'Change password', screenWidth:screenWidth),
                          ),
                          SizedBox(height:spaceUnderTitle),
                          Text('Check your email'),
                          Text(info),
                          InputField(name: 'Login'),
                          InputField(name: 'Password'),
                          InputField(name: 'Repeat Password'),
                          InputField(name: 'Email'),
                          Center(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Container(
                                  // margin: EdgeInsets.fromLTRB(200, 20, 50, 0),
                                  child: FilledButton(
                                    child: Text(
                                      'Change password',
                                      style: TextStyle(color: Colors.white, fontSize: 22),
                                    ),
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        print('form submiitted');
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => NavBarClass()));
                                      }
                                    },
                                  ),
                                  width: buttonWidth,
                                  height:buttonHeight,
                                ),
                              )),
                        ],
                      )),
                ),
              )),]
    );
  }
}


