import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../NavBarPages/homePage.dart';
import '../NavBarPages/navBar.dart';
import 'widgetClasses.dart';
import 'signUp.dart';
import 'changePassword.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/photos/logo_Tyskacz_light.png'),
                ),
              ),
            ),
            SizedBox(height:20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            SizedBox(height:20),
            InputField(name: 'Login'),
            InputField(name: 'Password'),
            TextButton(text: 'Forgot password?', navigationText: 'Change password', navigationType: NavigationType.changePassword),
            SizedBox(
              height: 65,
              width: 360,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: FilledButton(
                    child: Text( 'Log in ', style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: (){
                      print('Successfully log in ');
                      //go to home page with navbar
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NavBarClass()));
                    },

                  ),
                ),
              ),
            ),

            SizedBox(
              height: 50,
            ),
            TextButton(text: 'Don\'t have an account?', navigationText: 'Create an account', navigationType: NavigationType.signUp),
          ],
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

