import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/generated/i18n.dart';

class HALT extends StatefulWidget {
  final Function notifyParent;
  final Map halt;

  HALT({Key key, @required this.notifyParent, @required this.halt}) : super(key: key);

  @override
  _HALTState createState() => _HALTState();
}

class _HALTState extends State<HALT> {
  @override
  Widget build(BuildContext context) {
    Map halt = widget.halt;

    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).chooseHalt)),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(children: [
              Text(S.of(context).explainHalt),
              Padding(padding: EdgeInsets.only(bottom: 10.0)),
              ...halt.keys.map((k) => CheckboxListTile(
                    // TODO: i18n support instead of a hack solution
                    title: Text(k.toString().substring(0, 1).toUpperCase() + k.toString().substring(1)),
                    value: halt[k],
                    onChanged: (newValue) {
                      setState(() {
                        halt[k] = newValue;
                        widget.notifyParent(halt);
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                  )),
            ])));
  }
}
