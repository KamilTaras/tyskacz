import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'widgetClasses.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: Text('register'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Check your email', style: Theme.of(context).textTheme.displayLarge),
                    ),
                    Text(info),
                    SizedBox(height:20),
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
                                'Register',
                                style: TextStyle(color: Colors.white, fontSize: 22),
                              ),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  print('form submiitted');
                                }
                              },
                            ),

                            width: MediaQuery.of(context).size.width,

                            height: 50,
                          ),
                        )),
                  ],
                )),
          ),
        ));
  }
}
