import 'package:tyskacz/DatabaseManagement/planInformation.dart';
import 'package:tyskacz/DatabaseManagement/attractionInformation.dart';
import 'package:latlong2/latlong.dart';

var mockPlan = Plan(
  name:'Mock Plan',
  listOfEvents: [
    Event(
      attractionWithinEvent: Attraction(
        name: 'Museum',
        description: 'Explore the fascinating world of art',
        coordinates: LatLng(0, 0),
        photoURL: "https://cdn.britannica.com/51/194651-050-747F0C18/Interior-National-Gallery-of-Art-Washington-DC.jpg",
        review: 'Great experience!',
        link: 'museum_website_url',
      ),
      startDate: DateTime(2023, 12, 1, 10, 0),
      endDate: DateTime(2023, 12, 1, 14, 0),
    ),
    Event(
      attractionWithinEvent: Attraction(
        name: 'Botanical Garden',
        description: 'Enjoy the beauty of nature at the botanical garden',
        coordinates: LatLng(0, 0),
        photoURL: "https://www.tasteaway.pl/wp-content/uploads/2021/04/Dubai-Miracle-Garden_wejscie-990x742.jpg",
        review: 'A peaceful retreat!',
        link: 'garden_website_url',
      ),
      startDate: DateTime(2023, 12, 2, 9, 0),
      endDate: DateTime(2023, 12, 2, 12, 0),
    ),
  ],
  tripType: TripType.sightseeingTrip,
);

