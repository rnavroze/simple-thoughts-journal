import 'package:flutter/material.dart';

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
        appBar: AppBar(title: Text('Choose HALT')),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(children: [
              ...halt.keys.map((k) => CheckboxListTile(
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
