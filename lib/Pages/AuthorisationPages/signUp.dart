import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../NavBarPages/navBar.dart';
import 'widgetClasses.dart';
import '../background.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Map userData = {};
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double logSize = screenHeight * 0.2;
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Container(
                            width: logSize,
                            height: logSize,
                            child: Image.asset('assets/photos/logo_TySkacz_light.png'),
                          ),
                        ),
                      ),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => NavBarClass()));
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
          )),]
    );
  }
}


