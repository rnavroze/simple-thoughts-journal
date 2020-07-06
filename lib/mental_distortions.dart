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

Widget buildDistortionCardContents(Distortion distortion, BuildContext context) {
  return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
              backgroundImage: AssetImage('assets/${distortion.icon}'),
              radius: MediaQuery.of(context).size.width * 0.125),
          Padding(padding: EdgeInsets.only(right: 16.0)),
          Expanded(
              child: MarkdownBody(
                data: "### ${distortion.name}\n\n${distortion.description}",
              ))
        ],
      ));
}