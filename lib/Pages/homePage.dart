import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(70.0),
              child: Image(
                image: AssetImage('assets/photos/logo_TySkacz_light.png'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(child: FilledButton(onPressed: () {}, child: Container())),
                SizedBox(width: 10,),
                SizedBox(
                  height: 100,
                  width: 100,
                  child:  FilledButton(

                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black54,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),

                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Nice\ndick'),
                      ],
                    ),
                  )
                )
              ],
            ),
            Text(
              'Home Page',
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ],
    );
  }
}
