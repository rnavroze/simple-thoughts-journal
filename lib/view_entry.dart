import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mood_journal/generated/i18n.dart';
import 'package:mood_journal/journal_entry.dart';
import 'package:mood_journal/mental_distortions.dart';

import 'new_entry.dart';

class ViewEntry extends StatefulWidget {
  final JournalEntry journalEntry;
  final Function notifyParent;

  ViewEntry({Key key, @required this.journalEntry, @required this.notifyParent}) : super(key: key);

  @override
  _ViewEntryState createState() => _ViewEntryState();
}

class _ViewEntryState extends State<ViewEntry> {
  final _biggerFont = TextStyle(fontSize: 16.0);
  final _titleFont = TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(S.of(context).viewEntry),
        ),
        body: FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString('assets/distortions.json'),
            builder: (context, snapshot) {
              if (snapshot?.data == null) return Container();

              List<Distortion> distortions = [];

              final decoded = json.decode(snapshot.data.toString());
              for (final distortion in decoded) {
                distortions.add(Distortion.fromJson(distortion));
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    Text(widget.journalEntry.title, style: _titleFont),
                    Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                    Text(widget.journalEntry.details, style: _biggerFont),
                    Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                    Text(S.of(context).level(widget.journalEntry.level ?? S.of(context).notSelected), style: _biggerFont),
                    Padding(padding: const EdgeInsets.only(bottom: 16.0)),
                    Text(S.of(context).mentalDistortions, style: _titleFont),
                    Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                    ..._getDistortionCards(distortions, widget.journalEntry, context),
                    Padding(padding: const EdgeInsets.only(bottom: 16.0)),
                    Text(S.of(context).halt, style: _titleFont),
                    Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                    ..._getHaltCards(widget.journalEntry, context),
                    Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                    _getHalts(widget.journalEntry).length == 0
                        ? Container()
                        : CheckboxListTile(
                            title: Text(S.of(context).haltSolutionView, style: _biggerFont),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (value) {
                              _goToEdit();
                            },
                            value: widget.journalEntry.haltSolution,
                          ),
                    Padding(padding: const EdgeInsets.only(bottom: 16.0)),
                    Text(S.of(context).rationalThought, style: _titleFont),
                    Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                    Text(widget.journalEntry.rationalThought, style: _biggerFont),
                    Padding(padding: const EdgeInsets.only(bottom: 80.0)),
                    Text(S.of(context).illustrationsBy)
                  ]),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: _goToEdit,
          child: Icon(Icons.edit),
          backgroundColor: Colors.green,
        ));
  }

  List<Widget> _getDistortionCards(List<Distortion> distortions, JournalEntry entry, BuildContext context) {
    Map<int, Distortion> distortionsById = {};
    for (Distortion distortion in distortions) distortionsById.putIfAbsent(distortion.id, () => distortion);

    List<Widget> distortionCards = [];

    if (entry.distortions.length == 0) {
      distortionCards.add(Card(
          child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(S.of(context).noDistortionsSelected),
              ))));
    }
    entry.distortions.forEach((element) {
      distortionCards.add(Card(child: buildDistortionCardContents(distortionsById[element], context)));
    });

    return distortionCards;
  }

  Map _getHalts(JournalEntry entry) {
    return Map.from(entry.halt)..removeWhere((k, v) => v == false);
  }

  List<Widget> _getHaltCards(JournalEntry entry, BuildContext context) {
    List<Widget> haltCards = [];
    Map halts = _getHalts(entry);

    if (halts.length == 0) {
      haltCards.add(Card(
          child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(S.of(context).noHaltSelected),
              ))));
    } else {
      halts.forEach((k, v) {
        haltCards.add(Card(
            child: Container(
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // TODO: i18n support instead of this hack
                    child: Text(k.toString().substring(0, 1).toUpperCase() + k.toString().substring(1),
                        style: _biggerFont)))));
      });
    }

    return haltCards;
  }

  void _goToEdit() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddNewEntry(notifyParent: editFinished, existingEntry: widget.journalEntry)),
    );
  }

  void editFinished(JournalEntry entry) {
    widget.notifyParent(entry);
    setState(() {});
  }
}
