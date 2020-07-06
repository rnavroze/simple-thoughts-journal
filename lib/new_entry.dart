import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/halt.dart';
import 'package:mood_journal/mental_distortions.dart';

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
            title: new Text('Warning'),
            content: new Text('Are you sure you wish to go back without saving this entry?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
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
              title: Text('Add New Entry'),
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
                                hintText: 'Title',
                                value: _journalEntry.title,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Enter title';
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
                                hintText: 'Details',
                                value: _journalEntry.details,
                                maxLines: 3,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Enter details';
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
                                          child: Text('Mental Distortions'))),
                                  Text('${_journalEntry.distortions.length.toString()} selected')
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
                                          child: Text('HALT'))),
                                  Text(
                                      '${(Map.from(_journalEntry.halt)..removeWhere((k, v) => v == false)).length.toString()} selected')
                                ],
                              ),
                              CustomTextFormField(
                                hintText: 'Rational Thought',
                                value: _journalEntry.rationalThought,
                                maxLines: 3,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Enter rational thought';
                                  }
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
                                      _journalEntry.date = DateTime.now();
                                      widget.notifyParent(_journalEntry);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(_journalEntry.id == null ? 'Add New Entry' : 'Finish Editing'))
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
