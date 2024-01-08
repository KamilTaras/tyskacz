import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/attraction.dart';
import '../view_models/attraction_provider.dart';

class AddAttractionPage extends StatefulWidget {
  @override
  _AddAttractionPageState createState() => _AddAttractionPageState();
}

class _AddAttractionPageState extends State<AddAttractionPage> {
// Default value or validation
  final _formKey = GlobalKey<FormState>();


  String title = 'Default Title';
  String description = 'Default Description';
  String photos = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.klook.com%2Fcity%2F107-paris-things-to-do%2F&psig=AOvVaw2xi_RcuTCEzvny6j9zO8u8&ust=1704721163178000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCPDH8Kyzy4MDFQAAAAAdAAAAABAD";
  DateTime date = DateTime.now();
  double latitude = 0.0;
  double longitude = 0.0;
  String location = 'Paris, ŁĄCZMNA 43';

  String get _formattedDate => "${date.year}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}";
  // Initialize other fields like date, latitude, longitude, location, and photos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Attraction'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget> [
              TextFormField(
                initialValue: title,
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => title = value ?? title,
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value ?? description,
              ),
              TextFormField(
                initialValue: photos,
                decoration: InputDecoration(labelText: 'Photo URL'),
                onSaved: (value) => photos = value ?? photos,
              ),
              TextFormField(
                initialValue: _formattedDate,
                decoration: InputDecoration(labelText: 'Date (yyyy-mm-dd)'),
                onSaved: (value) {
                  date = value != null ? DateTime.tryParse(value) ?? date : date;
                },),
              TextFormField(
                initialValue: latitude.toString(),
                decoration: InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                onSaved: (value) => latitude = double.tryParse(value ?? '0.0') ?? 0.0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid latitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: longitude.toString(),
                decoration: InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                onSaved: (value) => longitude = double.tryParse(value ?? '0.0') ?? 0.0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid longitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: location,
                decoration: InputDecoration(labelText: 'Location'),
                onSaved: (value) => location = value ?? '',
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Attraction'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newAttraction = Attraction(
        title: title,
        photos: photos,
        description: description,
        latitude: latitude,
        longitude: longitude,
        location: location,
      );
      Provider.of<AttractionProvider>(context, listen: false)
          .addNewAttraction(newAttraction)
      //     .then((_) {
      //   Navigator.of(context).pop(); // Go back to the previous screen
      // })
          ;
    }
  }
}
