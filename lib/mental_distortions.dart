import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Distortion {
  String id;
  String name;
  String description;
  String icon;

  factory Distortion.fromJson(Map<String, dynamic> json) => Distortion(
      name: json['name'],
      description: json['description'].join("  \n"),
      icon: json['icon']);

  Map<String, dynamic> toJson() =>
      {"name": name, "description": description, "icon": icon};

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
            future: DefaultAssetBundle.of(context)
                .loadString('assets/distortions.json'),
            builder: (context, snapshot) {
              List<Distortion> distortions = [];
              final decoded = json.decode(snapshot.data.toString());
              for (final distortion in decoded) {
                distortions.add(Distortion.fromJson(distortion));
              }

              List<Widget> distortionCards = [];
              for (final distortion in distortions) {
                distortionCards.add(Card(
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/Filtering.png'),
                              fit: BoxFit.cover,
                              width: 40.0,
                              height: 40.0,
                            ),
                            Padding(padding: EdgeInsets.only(right: 16.0)),
                            Expanded(
                                child: MarkdownBody(
                              data:
                                  "### ${distortion.name}\n\n${distortion.description}",
                            ))
                          ],
                        ))));
              }

              return SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: distortionCards,
                    ),
                  ));
            }));
  }
}
