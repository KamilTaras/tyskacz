import 'package:flutter/material.dart';

class AttractionDescriptionPage extends StatelessWidget {
  final double componentsMargin = 5.0;
  final double ratingFontSize = 20.0;

  Widget buildRatingTextWithPlaceholder(String labelText) {
    return Expanded(
      flex: 4,
      child: Container(
        height: 35,
        child: Text(
          labelText,
          style: TextStyle(
            fontSize: ratingFontSize,
          ),
        ),
      ),
    );
  }

  Widget buildRatingRowWithTextAndPlaceholder(String labelText) {
    return Row(
      children: <Widget>[
        buildRatingTextWithPlaceholder(labelText),
        SizedBox(width: 20),
        Expanded(
          flex: 4,
          child: Placeholder(
            fallbackWidth: 100,
            fallbackHeight: 30,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              // SETTING WHOLE SCREEN SIZEING
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.height * 0.95 - 20,
              color: Color(0xFFEBE9FF),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                //collumn for content
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Placeholder(
                      fallbackWidth: 300,
                      fallbackHeight: 200,
                    ),
                    //ATTRACTION NAME
                    Container(
                      margin: EdgeInsets.symmetric(vertical: componentsMargin),
                      height: 40,
                      color: Color(0xFFE31CC9E),
                      child: Center(
                        child: Text(
                          'Attraction Name',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: componentsMargin),
                      height: 70,
                      color: Colors.pink,
                      child: Column(
                        children: <Widget>[
                          buildRatingRowWithTextAndPlaceholder('Average Rating:'),
                          buildRatingRowWithTextAndPlaceholder('Your Rating:'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
