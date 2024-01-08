// import 'package:flutter/material.dart';
// import '../models/attraction.dart';
// import '../services/database_service.dart';
// import 'attraction_details_page.dart';
//
// class FavoritesPage extends StatelessWidget {
//   final DatabaseService databaseService = DatabaseService();
//
//   FavoritesPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorites'),
//       ),
//       body: FutureBuilder<List<Attraction>>(
//         future: databaseService.getFavoriteAttractions(), // Implement thQis method in DatabaseService
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Text('No favorite attractions');
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               Attraction attraction = snapshot.data![index];
//               return ListTile(
//                 title: Text(attraction.title),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AttractionDetailsPage(attraction: attraction),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
