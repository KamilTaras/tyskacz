import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../DatabaseManagement/database.dart';
import '../../DatabaseManagement/userInformation.dart';
import '../NavBarPages/homePage.dart';
import '../NavBarPages/navBar.dart';
import 'widgetClasses.dart';
import 'signUp.dart';
import 'changePassword.dart';
import '../uiElements.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseService databaseService = DatabaseService();
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
               Container(
                      width: logoSize,
                      height: logoSize,
                      child: Image.asset('assets/photos/logo_TySkacz_light.png'),
                    ),
                SizedBox(height:spaceUnderTitle),
                CreateTitle(title: 'Sign In', screenWidth:screenWidth),
                InputField(name: 'Login', controller:_userNameController),
                InputField(name: 'Password', controller:_passwordController),
                TextButton(text: 'Forgot password?', navigationText: 'Change password', navigationType: NavigationType.changePassword),
                SizedBox(
                  height: buttonHeight,
                  width: buttonWidth,
                  child: Container(
                      child: FilledButton(
                        child: Text( 'Log in ', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'MainFont'),
                        ),
                        onPressed: ()async{
                          //go to home page with navbar
                        User? user = await databaseService.getUserByName(_userNameController.text);
                        if(user!=null){
                          if(user.checkPassword( _passwordController.text)){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Successfully logged in'),
                                duration: Duration(seconds: 2),
                              ),
                            );

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBarClass(user: user)));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Wrong password'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Wrong username'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                        },

                      ),
                  ),
                ),
                Text('Don\'t have an account?', style:TextStyle(fontSize:16, fontFamily: 'MainFont')),
                TextButton(text: '', navigationText: 'Create an account', navigationType: NavigationType.signUp),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style:TextStyle(fontSize:16, fontFamily: 'MainFont')),
            InkWell(
              onTap: () => _handleNavigation(context),
              child: Text(navigationText,
                  style: TextStyle(fontSize: 14, color: Colors.blue, fontFamily: 'MainFont')),
            )
          ],
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context) {
    switch (navigationType) {
      case NavigationType.changePassword:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChangePassword()));
        break;
      case NavigationType.signUp:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUp()));
    }
  }
}


enum NavigationType {
  changePassword,
  signUp,
}

