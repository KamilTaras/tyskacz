import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:tyskacz/Pages/AuthorisationPages/signIn.dart';
import '../../DatabaseManagement/database.dart';
import '../../DatabaseManagement/userInformation.dart';
import '../NavBarPages/navBar.dart';
import 'widgetClasses.dart';
import '../background.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final DatabaseService databaseService = DatabaseService();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double logSize = screenHeight * 0.2;
    final double spaceUnderTitle = screenHeight * 0.2;

        return Stack(
      children: [
        BackgroundSignUp(),
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
                      CreateTitle(title: 'Sign Up', screenWidth:screenWidth),
                      SizedBox(height:spaceUnderTitle),
                      InputField(name: 'Login', controller:_userNameController),
                      InputField(name: 'Password', controller:_passwordController),
                      InputField(name: 'Repeat Password', controller:_repeatPasswordController),
                      InputField(name: 'Email', controller:_emailController),
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
                                  if (_formkey.currentState!.validate()&&_passwordController.text==_repeatPasswordController.text) {
                                    databaseService.addUser(User.newPassword(name: _userNameController.text, password: _passwordController.text, email: _emailController.text));
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
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


