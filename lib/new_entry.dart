import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Mood { verySad, sad, neutral, happy, veryHappy }

class JournalEntry {
  String title;
  int level;

//  Mood mood;
  String details;
  List thoughts;
  List halt;
  String rationalThought;

  JournalEntry(
      {this.title,
      this.level,
      this.details,
      this.thoughts,
      this.halt,
      this.rationalThought});
}

class AddNewEntry extends StatefulWidget {
  final Function notifyParent;

  AddNewEntry({Key key, @required this.notifyParent}) : super(key: key);

  @override
  _AddNewEntryState createState() => _AddNewEntryState();
}

class _AddNewEntryState extends State<AddNewEntry> {
  final _formKey = GlobalKey<FormState>();
  JournalEntry _journalEntry = new JournalEntry();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
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
                                  icon: Icon(this._journalEntry.level == 1
                                      ? Icons.looks_one
                                      : Icons.filter_1),
                                  onPressed: () => setState(
                                      () => this._journalEntry.level = 1)),
                              IconButton(
                                  icon: Icon(this._journalEntry.level == 2
                                      ? Icons.looks_two
                                      : Icons.filter_2),
                                  onPressed: () => setState(
                                      () => this._journalEntry.level = 2)),
                              IconButton(
                                  icon: Icon(this._journalEntry.level == 3
                                      ? Icons.looks_3
                                      : Icons.filter_3),
                                  onPressed: () => setState(
                                      () => this._journalEntry.level = 3)),
                              IconButton(
                                  icon: Icon(this._journalEntry.level == 4
                                      ? Icons.looks_4
                                      : Icons.filter_4),
                                  onPressed: () => setState(
                                      () => this._journalEntry.level = 4)),
                              IconButton(
                                  icon: Icon(this._journalEntry.level == 5
                                      ? Icons.looks_5
                                      : Icons.filter_5),
                                  onPressed: () => setState(
                                      () => this._journalEntry.level = 5)),
                            ],
                          ),
                          CustomTextFormField(
                            hintText: 'Details',
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
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 5.0, 8.0, 5.0),
                                  child: RaisedButton(
                                      onPressed: () {},
                                      child: Text('Mental Distortions'))),
                              Text('0 selected')
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 5.0, 8.0, 5.0),
                                child: RaisedButton(
                                    onPressed: () {}, child: Text('HALT')),
                              ),
                              Text('0 selected')
                            ],
                          ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      RaisedButton(
//                          onPressed: () {}, child: Text('Mental Distortions')),
//                      RaisedButton(onPressed: () {}, child: Text('HALT')),
//                    ],
//                  ),
                          CustomTextFormField(
                            hintText: 'Rational Thought',
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
                                  widget.notifyParent();
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('Add New Entry'))
                        ],
                      )),
                ))));
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

  CustomTextFormField({
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
