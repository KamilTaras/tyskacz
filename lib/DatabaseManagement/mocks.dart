import 'package:tyskacz/DatabaseManagement/planInformation.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';
import 'package:latlong2/latlong.dart';

var mockUserPlanList = [
Plan(
name:'Murcki Plan',
listOfEvents: [
Event(
attractionWithinEvent: mockAttractionList[0],
startDate: DateTime(2023, 12, 1, 10, 0),
endDate: DateTime(2023, 12, 1, 14, 0),
),
Event(
attractionWithinEvent: mockAttractionList[1],
startDate: DateTime(2023, 12, 2, 9, 0),
endDate: DateTime(2023, 12, 2, 12, 0),
),
  Event(
    attractionWithinEvent: mockAttractionList[2],
    startDate: DateTime(2023, 12, 2, 9, 0),
    endDate: DateTime(2023, 12, 2, 12, 0),
  ),
],
tripType: TripType.sightseeingTrip,
),
  Plan(
    name: 'Paris Plan',
    listOfEvents: [
      Event(
        attractionWithinEvent: mockAttractionList[3],
        startDate: DateTime(2024, 1, 10, 10, 0),
        endDate: DateTime(2024, 1, 10, 14, 0),
      ),
      Event(
        attractionWithinEvent: mockAttractionList[4],
        startDate: DateTime(2024, 1, 10, 10, 0),
        endDate: DateTime(2024, 1, 10, 14, 0),
      ),
    ],
  tripType: TripType.sightseeingTrip,
  )
];


var mockAttractionList = [
Attraction(
name: 'Museum',
description: 'Explore the fascinating world of art',
coordinates: LatLng(50.1948281344449, 19.03998550610865),
photoURL: "https://cdn.britannica.com/51/194651-050-747F0C18/Interior-National-Gallery-of-Art-Washington-DC.jpg",
review: 'Great experience!',
link: 'museum_website_url',
),
Attraction(
name: 'Botanical Garden',
description: 'Enjoy the beauty of nature at the botanical garden',
coordinates: LatLng(50.196588480477416, 19.034980302523326),
photoURL: "https://www.tasteaway.pl/wp-content/uploads/2021/04/Dubai-Miracle-Garden_wejscie-990x742.jpg",
review: 'A peaceful retreat!',
link: 'garden_website_url',
),
Attraction(
name: 'Bojo Murcki',
description: 'cho zagrac z ziomkami w gale',
coordinates: LatLng(50.1999325404822, 19.04639177968384),
photoURL: "https://lh5.googleusercontent.com/p/AF1QipNs0b15XKft23yzIjEkl7rkBlrIctKphfiN-MWs",
review: 'fajne!',
link: 'garden_website_url',
),
Attraction(
name: 'Pigs in Paris',
description: 'Yoooooo the fat minecraft pigs really are in the capital of France!',
coordinates: LatLng(48.84819668323813, 2.3356259252416267),
photoURL: "https://i.ibb.co/VC549LS/Fat-Pig.png",
review: 'Great experience!',
link: 'museum_website_url',
),
Attraction(
name: 'Tank you!',
description: 'Enjoy the beauty of AMX 50 B heavy tank',
coordinates: LatLng(48.78300398866931, 2.104529681502329),
photoURL: "https://aw.my.games/sites/aw.my.com/files/u183517/amx-50.jpg",
review: 'A peaceful retreat!',
link: 'garden_website_url',
),
];

