import 'package:flutter/material.dart';
import '../constantValues.dart';

class AttractionDescriptionPage extends StatelessWidget {
  final double componentsMargin = 5.0;
  final double ratingFontSize = 20.0;
  final double titleFontSize = 25.0;
  final double mainContainerMargin = 10.0;
  final double topBarHeight = 20.0;
  final String text =
      "New the her nor case that lady paid read. Invitation friendship travelling eat everything the out two. Shy you who scarcely expenses debating hastened resolved. Always polite moment on is warmth spirit it to hearts. Downs those still witty an balls so chief so. Moment an little remain no up lively no. Way brought may off our regular country towards adapted cheered.Literature admiration frequently indulgence announcing are who you her. Was least quick ";

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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: topBarHeight,
            ),
            Container(
              // SETTING WHOLE SCREEN SIZEING
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  vertical: mainContainerMargin, horizontal: mainContainerMargin),
              width: MediaQuery.of(context).size.width - 2 * mainContainerMargin,
              height: MediaQuery.of(context).size.height -
                  topBarHeight -
                  2 * mainContainerMargin,
              decoration: BoxDecoration(
                color: Constant.mainBackgroundColor,
                borderRadius: BorderRadius.circular(10.0), // Adjust the border radius
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                // column for content
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Placeholder(
                      fallbackWidth: 300,
                      fallbackHeight: 200,
                    ),
                    // ATTRACTION NAME
                    Container(
                      margin: EdgeInsets.symmetric(vertical: componentsMargin),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Constant.mainGreenColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          'Attraction Name',
                          style: TextStyle(
                            fontSize: titleFontSize,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: componentsMargin),
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          buildRatingRowWithTextAndPlaceholder('Average Rating:'),
                          buildRatingRowWithTextAndPlaceholder('Your Rating:'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: componentsMargin),
                      height: 250,
                      decoration: BoxDecoration(
                        color: Constant.mainBackgroundColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                          child: Text(
                            text,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: componentsMargin),
                      height: 140,
                      decoration: BoxDecoration(
                        color: Constant.mainRedColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 8),
                          Icon(
                            Icons.star,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Attraction Name',
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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



