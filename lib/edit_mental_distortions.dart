import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mood_journal/generated/i18n.dart';
import 'mental_distortions.dart';

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
          title: Text(S.of(context).chooseDistortions),
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
                          child: buildDistortionCardContents(distortion, context)),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(S.of(context).explainDistortions),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    ...distortionCards,
                    Padding(padding: EdgeInsets.only(top: 8.0)),
                    Text(S.of(context).illustrationsBy)
                  ],
                ),
              ));
            }));
  }
}
