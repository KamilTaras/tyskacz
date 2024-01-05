import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Container(
                          width: 200,
                          height: 150,
                          //decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(40),
                          //border: Border.all(color: Colors.blueGrey)),
                          child: Image.asset('assets/logo.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(


                        decoration: InputDecoration(
                            hintText: 'Enter first Name',
                            labelText: 'first named',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                            errorStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                BorderRadius.all(Radius.circular(9.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Enter last Name',
                            labelText: 'Last named',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            errorStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                BorderRadius.all(Radius.circular(9.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.lightBlue,
                            ),
                            errorStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                BorderRadius.all(Radius.circular(9.0)))),
                      ),
                    ),
                    InputField(name: 'Repeat password'),
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

class InputField{
  String name;

  InputField({required this.name});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: 'Mobile',
            labelText: 'Mobile',
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius:
                BorderRadius.all(Radius.circular(9)))),
      ),
    );
  }

}