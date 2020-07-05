import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mood_journal/new_entry.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'journal_entry.dart';

void main() {
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Journal',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MoodJournalHome(title: 'Mood Journal'),
    );
  }
}

class MoodJournalHome extends StatefulWidget {
  MoodJournalHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MoodJournalHomeState createState() => _MoodJournalHomeState();
}

class _MoodJournalHomeState extends State<MoodJournalHome> {
  final _biggerFont = TextStyle(fontSize: 18.0);
  final DateFormat formatter = DateFormat('MMMM d, y');

  List<JournalEntry> _journalEntries = [];

  Future<Database> database;
  Future<void> setupDatabase() async {
    print('we are here');
    print(path.join(await getDatabasesPath(), 'mood_journal.db'));

    database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      path.join(await getDatabasesPath(), 'mood_journal.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, level INTEGER, details STRING, distortions STRING, halt STRING, rational_thought STRING, date STRING)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  _MoodJournalHomeState() { setupDatabase();
  print("done");
  }

  Future<List<Map<String,dynamic>>> getTest() async {
    print("we are here too");
    final Database db = await database;
    print((await db.query('journal_entries')).toString());
    return await db.query('journal_entries');
  }
  Future<void> addNewJournalEntry(JournalEntry entry) async {
    final Database db = await database;

    await db.insert(
      'journal_entries',
      {
        'title': entry.title,
        'level': entry.level,
        'details': entry.details,
        'distortions': entry.distortions.join(','),
        'halt': json.encode(entry.halt),
        'rational_thought': entry.rationalThought,
        'date': entry.date.toIso8601String()
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    setState(() {
      _journalEntries.add(entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            getTest();
          },
        ),
      ),
      body: ListView(children: _journalEntries.map((entry) => Card(child: _buildRow(entry))).toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewEntry(notifyParent: addNewJournalEntry)),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildRow(JournalEntry entry) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddNewEntry(notifyParent: addNewJournalEntry, existingEntry: entry)),
      ),
      title: Text(
        entry.title,
        style: _biggerFont,
      ),
      subtitle: Text(formatter.format(entry.date)),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          Widget yesButton = FlatButton(
            child: Text("Delete"),
            onPressed: () {
              _journalEntries.remove(entry);
              Navigator.of(context).pop();
            },
          );
          Widget noButton = FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );

          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            title: Text("Confirm Delete"),
            content: Text("Are you sure you would like to delete this entry?"),
            actions: [
              noButton,
              yesButton,
            ],
          );

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
