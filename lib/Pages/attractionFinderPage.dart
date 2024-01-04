import 'package:flutter/material.dart';
import 'atttractionDescription.dart';

class AttractionFinderPage extends StatefulWidget {
  const AttractionFinderPage({super.key});

  @override
  State<AttractionFinderPage> createState() => _AttractionFinderPage();
}
class _AttractionFinderPage extends State<AttractionFinderPage> {


  Widget buildTextContainer(double height, String name, double fontSize) {
    return Container(
      height: height,
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }

List <MockAttraction> attractionList=[
  MockAttraction(name: 'Eiffel Tower', picPath:'assets/photos/logo_TySkacz_light.png',description: '''najbardziej znany obiekt architektoniczny Paryża, uznawany za symbol tego miasta i 
  niekiedy całej Francji. Jest najwyższą budowlą w Paryżu, a w momencie powstania była najwyższą budowlą na świecie. „Żelazna dama” stoi w zachodniej części miasta, 
  nad Sekwaną, na północno-zachodnim krańcu Pola Marsowego'''),
  MockAttraction(name: 'Pigs in Paris', picPath:'assets/photos/logo_TySkacz_light.png',description: 'building'),
  MockAttraction(name: 'Tank u', picPath:'assets/photos/logo_TySkacz_light.png',description: 'buildin'),
  MockAttraction(name: 'Paprikash monument', picPath:'assets/photos/logo_TySkacz_light.png',description: 'buildin'),
  MockAttraction(name: 'Eiffel Tower', picPath:'assets/photos/logo_TySkacz_light.png',description: 'zachodniej części miasta, nad Sekwaną, na północno-zachodnim krańcu Pola Marsowego'),
  MockAttraction(name: 'Pigs in Paris', picPath:'assets/photos/logo_TySkacz_light.png',description: 'buildin'),
  MockAttraction(name: 'Tank u', picPath:'assets/photos/logo_TySkacz_light.png',description: 'buildin'),
  MockAttraction(name: 'Paprikash monument', picPath:'assets/photos/logo_TySkacz_light.png',description: 'buildin')
];

  final double pageNameFontSize = 15;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // preferredSize: Size.fromHeight(30.0),s
      ),
      body: SafeArea(
        child: Column(
          children: <Widget> [
            Container(
              height: 50,
                width: 200,
                child: Text(
                  'Select attractions you would like to visit',
                  style: TextStyle(fontSize: pageNameFontSize, fontWeight: FontWeight.bold),
                )
            )
            ,
             Expanded(
               child: ListView.builder(
                 itemCount: attractionList.length,
                 itemBuilder:(context, index){
                   return AttractionEntry(attraction: attractionList[index]);
                 },
               ),
             ),
            SizedBox(height: 50), // Optional spacing
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 100,
                child: FilledButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Pack Your Bags'),
                ),
              ),
            ),
            SizedBox(height: 20),
          ] ,
        ),
      ),
    );
  }
}
class AttractionEntry extends StatelessWidget {
  AttractionEntry({super.key, required this.attraction});
  final MockAttraction attraction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //TODO: on drag add to plan
      onTap: (){
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => AttractionDescriptionPage()));
        },
      //TODO: in dark mode, text is not visible
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          //set border radius more than 50% of height and width to make circle
          ),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  height:100,
                  width:120,
                  child: Image(
                    image: AssetImage(attraction.picPath),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(attraction.name),
                    Container(height:70,
                        child: Text(attraction.description,style:TextStyle(fontSize: 10))
                    )
                    // Other widgets if needed
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget buildIconWithText(){
  //
  // }
}


class MockAttraction {

  String name;
  String picPath;
  String description;

  MockAttraction({required this.name, required this.picPath, required this.description});
}