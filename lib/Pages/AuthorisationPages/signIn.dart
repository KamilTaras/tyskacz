import 'package:flutter/material.dart';
import 'signUp.dart';
import 'changePassword.dart';
import 'widgetClasses.dart';

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
                  //decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(40),
                  //border: Border.all(color: Colors.blueGrey)),
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
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone number, email or username',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
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
                    },

                  ),
                ),
              ),
            ),

            SizedBox(
              height: 50,
            ),
            Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 62),
                        child: Text('Don\'t have an account? '),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:1.0),
                        child: InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text('Create an account.', style: TextStyle(fontSize: 14, color: Colors.blue),)),
                      )
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
