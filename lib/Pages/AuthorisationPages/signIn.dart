import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../NavBarPages/homePage.dart';
import '../NavBarPages/navBar.dart';
import 'widgetClasses.dart';
import 'signUp.dart';
import 'changePassword.dart';
import '../background.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double logoSize = screenHeight * 0.2;
    final double buttonHeight = screenHeight * 0.08;
    final double buttonWidth = screenWidth * 0.9;
    final double spaceUnderTitle = screenHeight * 0.02;

    return Stack(
      children:[
        Background(),
        Scaffold(
        appBar: AppBar(
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Container(
                    width: logoSize,
                    height: logoSize,
                    child: Image.asset('assets/photos/logo_TySkacz_light.png'),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Sign In',
                    style:  TextStyle(fontFamily: 'MainFont', fontSize: 40, color: Colors.grey[900]),
                  ),
                ),
              ),
              SizedBox(height:spaceUnderTitle),
              InputField(name: 'Login'),
              InputField(name: 'Password'),
              TextButton(text: 'Forgot password?', navigationText: 'Change password', navigationType: NavigationType.changePassword),
              SizedBox(
                height: buttonHeight,
                width: buttonWidth,
                child: Container(
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
              TextButton(text: 'Don\'t have an account?', navigationText: 'Create an account', navigationType: NavigationType.signUp),
            ],
          ),
        ),
      ),]
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
              padding: const EdgeInsets.only(left: 62, top: 20, bottom: 20, right: 10),
              child: Text(text),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1.0, top: 20, bottom: 20),
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

