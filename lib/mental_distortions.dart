import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Distortion {
  int id;
  String name;
  String description;
  String icon;

  factory Distortion.fromJson(Map<String, dynamic> json) =>
      Distortion(id: json['id'], name: json['name'], description: json['description'].join("  \n"), icon: json['icon']);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "description": description, "icon": icon};

  Distortion({this.id, this.name, this.description, this.icon});
}

class MentalDistortions extends StatefulWidget {
  final Function notifyParent;
  final Set distortionIds;

  MentalDistortions({Key key, @required this.notifyParent, @required this.distortionIds}) : super(key: key);

  @override
  _MentalDistortionsState createState() => _MentalDistortionsState();
}

class _MentalDistortionsState extends State<MentalDistortions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Choose Distortions'),
        ),
        body: FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString('assets/distortions.json'),
            builder: (context, snapshot) {
              if (snapshot?.data == null) return Container();

              List<Distortion> distortions = [];
              Set distortionIds = widget.distortionIds;

              final decoded = json.decode(snapshot.data.toString());
              for (final distortion in decoded) {
                distortions.add(Distortion.fromJson(distortion));
              }

              List<Widget> distortionCards = [];
              for (final distortion in distortions) {
                distortionCards.add(Card(
                  child: InkWell(
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          decoration:
                              BoxDecoration(color: distortionIds.contains(distortion.id) ? Colors.tealAccent : null),
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                      backgroundImage: AssetImage('assets/${distortion.icon}'),
//                                  fit: BoxFit.cover,
                                      radius: MediaQuery.of(context).size.width * 0.125),
                                  Padding(padding: EdgeInsets.only(right: 16.0)),
                                  Expanded(
                                      child: MarkdownBody(
                                    data: "### ${distortion.name}\n\n${distortion.description}",
                                  ))
                                ],
                              ))),
                      onTap: () {
                        setState(() {
                          if (distortionIds.contains(distortion.id))
                            distortionIds.remove(distortion.id);
                          else
                            distortionIds.add(distortion.id);

                          widget.notifyParent(distortionIds);
                        });
                      }),
//                    color: distortionIds.contains(distortion.id) ? Colors.tealAccent : null));
                ));
              }

              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: distortionCards,
                ),
              ));
            }));
  }
}
