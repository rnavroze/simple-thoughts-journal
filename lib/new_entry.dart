import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/generated/i18n.dart';
import 'package:mood_journal/halt.dart';
import 'package:mood_journal/edit_mental_distortions.dart';

import 'journal_entry.dart';

class AddNewEntry extends StatefulWidget {
  final Function notifyParent;
  final JournalEntry existingEntry;

  AddNewEntry({Key key, @required this.notifyParent, this.existingEntry}) : super(key: key);

  @override
  _AddNewEntryState createState() => _AddNewEntryState(this.existingEntry);
}

class _AddNewEntryState extends State<AddNewEntry> {
  final _formKey = GlobalKey<FormState>();
  JournalEntry _journalEntry = new JournalEntry();

  _AddNewEntryState(JournalEntry existingEntry) {
    if (existingEntry != null) {
      _journalEntry = existingEntry;
    } else {
      _journalEntry.distortions = Set();
      _journalEntry.halt = {'hungry': false, 'angry': false, 'lonely': false, 'tired': false};
    }
  }

  void _updateDistortions(Set distortionIds) {
    setState(() {
      _journalEntry.distortions = distortionIds;
    });
  }

  void _updateHALT(Map halt) {
    setState(() {
      _journalEntry.halt = halt;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(S.of(context).warning),
            content: new Text(S.of(context).exitEditorWarning),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(S.of(context).no),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text(S.of(context).yes),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(_journalEntry.id == null ? S.of(context).addEntryTitle : S.of(context).editEntryTitle),
            ),
            body: SingleChildScrollView(
                reverse: true,
                child: Padding(
                    padding: EdgeInsets.only(bottom: bottom),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              CustomTextFormField(
                                hintText: S.of(context).title,
                                value: _journalEntry.title,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return S.of(context).titleError;
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  _journalEntry.title = value;
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(this._journalEntry.level == 1 ? Icons.looks_one : Icons.filter_1),
                                      onPressed: () => setState(() => this._journalEntry.level = 1)),
                                  IconButton(
                                      icon: Icon(this._journalEntry.level == 2 ? Icons.looks_two : Icons.filter_2),
                                      onPressed: () => setState(() => this._journalEntry.level = 2)),
                                  IconButton(
                                      icon: Icon(this._journalEntry.level == 3 ? Icons.looks_3 : Icons.filter_3),
                                      onPressed: () => setState(() => this._journalEntry.level = 3)),
                                  IconButton(
                                      icon: Icon(this._journalEntry.level == 4 ? Icons.looks_4 : Icons.filter_4),
                                      onPressed: () => setState(() => this._journalEntry.level = 4)),
                                  IconButton(
                                      icon: Icon(this._journalEntry.level == 5 ? Icons.looks_5 : Icons.filter_5),
                                      onPressed: () => setState(() => this._journalEntry.level = 5)),
                                ],
                              ),
                              CustomTextFormField(
                                hintText: S.of(context).details,
                                value: _journalEntry.details,
                                maxLines: 3,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return S.of(context).detailsError;
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  _journalEntry.details = value;
                                },
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 8.0, 5.0),
                                      child: RaisedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MentalDistortions(
                                                      notifyParent: _updateDistortions,
                                                      distortionIds: _journalEntry.distortions)),
                                            );
                                          },
                                          child: Text(S.of(context).mentalDistortions))),
                                  Text(S.of(context).nSelected(_journalEntry.distortions.length.toString()))
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 8.0, 5.0),
                                      child: RaisedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HALT(notifyParent: _updateHALT, halt: _journalEntry.halt)),
                                            );
                                          },
                                          child: Text(S.of(context).halt))),
                                  Text(S.of(context).nSelected((Map.from(_journalEntry.halt)
                                        ..removeWhere((k, v) => v == false))
                                      .length
                                      .toString()))
                                ],
                              ),
                              Container(
                                  child: _journalEntry.id != null &&
                                          (Map.from(_journalEntry.halt)..removeWhere((k, v) => v == false)).length > 0
                                      ? CheckboxListTile(
                                          title: Text(S.of(context).haltSolutionEdit),
                                          value: _journalEntry.haltSolution ?? false,
                                          onChanged: (value) {
                                            setState(() {
                                              _journalEntry.haltSolution = value;
                                            });
                                          },
                                          controlAffinity: ListTileControlAffinity.trailing,
                                        )
                                      : null),
                              CustomTextFormField(
                                hintText: S.of(context).rationalThought,
                                value: _journalEntry.rationalThought,
                                maxLines: 3,
                                validator: (String value) {
//                                  if (value.isEmpty) {
//                                    return 'Enter rational thoughts';
//                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  _journalEntry.rationalThought = value;
                                },
                              ),
                              RaisedButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      if (_journalEntry.date == null) _journalEntry.date = DateTime.now();
                                      widget.notifyParent(_journalEntry);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(_journalEntry.id == null
                                      ? S.of(context).addNewEntry
                                      : S.of(context).finishEditing))
                            ],
                          )),
                    )))));
  }
}

/*Container(
                  alignment: Alignment.topCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[*/

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;
  final int maxLines;
  final String value;

  CustomTextFormField({
    this.value,
    this.hintText,
    this.validator,
    this.onSaved,
    this.maxLines = 1,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        initialValue: value,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        maxLines: maxLines,
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
