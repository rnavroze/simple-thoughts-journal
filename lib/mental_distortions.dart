import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Distortion {
  String name;
  String description;
  String icon;

  factory Distortion.fromJson(Map<String, dynamic> json) =>
      Distortion(
          name: json['name'],
          description: json['description'].join("<br>"),
          icon: json['icon']
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "description": description,
        "icon": icon
      };

  Distortion({this.name, this.description, this.icon});
}

class MentalDistortions extends StatefulWidget {
  final Function notifyParent;

  MentalDistortions({Key key, @required this.notifyParent}) : super(key: key);

  @override
  _MentalDistortionsState createState() => _MentalDistortionsState();
}

class _MentalDistortionsState extends State<MentalDistortions> {
//  final List<Distortion> _distortions;

//  Future<List<Distortion>> _loadDistortions() async {
//    String distortionsString = await rootBundle.loadString(
//        "assets/distortions.json");
//
//    var parsed;
//    try {
//      parsed = json.decode(distortionsString);
//    } on FormatException {
//      print("Invalid JSON string.");
//    } on NoSuchMethodError {
//      print("Null string.");
//    }
//
//    List<Distortion> distortions = [];
//    for (final distortion in parsed) {
//      distortions.add(Distortion.fromJson(distortion));
//    }
//
//    return distortions;
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Choose Distortions'),
        ),
        body: FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString(
                'assets/distortions.json'),
            builder: (context, snapshot) {
              List<Distortion> distortions = [];
              final decoded = json.decode(snapshot.data.toString());
              for (final distortion in decoded) {
                distortions.add(Distortion.fromJson(distortion));
              }

              List<Widget> distortionCards = [];
              for (final distortion in distortions) {
                distortionCards.add(Card(
                    child: ListTile(
                      title: Text(distortion.name),
                      subtitle: Html(data: distortion.description),
                    )));
              }

              return SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: distortionCards,
                    ),
                  )
              );
            }
        )
    );
  }
}
