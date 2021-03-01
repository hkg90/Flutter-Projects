import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project4_journal/pages/setting.dart';

import 'package:project4_journal/models/process_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project4_journal/app.dart';



class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  final String apptitle = 'New Entry';

  @override 
  Widget build(BuildContext context){
    return Scaffold(
       
        endDrawer: SettingsDrawer(),
        appBar: 
        AppBar(
          title: Text(apptitle),
          actions: [Builder( builder: (context) =>
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
          ),]
        ),
        body: 
            JournalEntryForm()
      );
  }
}


class JournalEntryFields {
  String title;
  String body;
  String dateTime;
  int rating;
  String toString(){
    return 'Title: $title, Body: $body, Time: $dateTime, Rating: $rating';
  }
  
}


class JournalEntryForm extends StatefulWidget {
  @override
  JournalEntryFormState createState() {
    return JournalEntryFormState();
  }
}


class JournalEntryFormState extends State<JournalEntryForm> {

  final formKey = GlobalKey<FormState>();
  final journalEntryFields = JournalEntryFields();
  

  @override
  Widget build(BuildContext context) {
    AppState state = context.findAncestorStateOfType<AppState>();

    // Build a Form widget using the _formKey created above.
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              // Title entry field
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Title', border: OutlineInputBorder()),
                
                // Store title and date/time in new journal object
                onSaved: (value) {
                  journalEntryFields.title = value;
                  final DateTime currentTime = DateTime.now();
                  //final DateFormat formatter = DateFormat('yyyy-MM-dd Hms');
                  final String formatted = currentTime.toIso8601String();
                 
                  journalEntryFields.dateTime = formatted;
                },
                
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a entry title';
                  }
                  return null;
                },),
                SizedBox(height:10),
              
              // Body entry field
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Body', border: OutlineInputBorder()),
                
                // Store body content in new journal object
                onSaved: (value) {
                  journalEntryFields.body = value;
                },

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter the entry's body content";
                  }
                  return null;
                },),
                SizedBox(height:10),
              
              // Rating entry field
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Rating', border: OutlineInputBorder()),
                
                // Store rating in new journal object
                onSaved: (value) {
                  journalEntryFields.rating = int.parse(value);
                },
                
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your number rating';
                  } else if (int.parse(value) > 4 || int.parse(value) < 1) {
                    return 'Please ensure rating is within range: 1-4';
                  }
                  return null;
                },),
                SizedBox(height:10),
              ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid
                  if (formKey.currentState.validate()) {
                    // If valid entry, save and submit data and go back to main screen
                    formKey.currentState.save();
                    
                    //Deletes database file (only used while app in development mode to ensure database starts fresh/ no saved entries)
                    //TODO: Delete deleteDatabase() later!
                    //await deleteDatabase('jounal.db');                    
                    // Open database file
                    Database database = await openDatabase(
                      'journal.db', version: 1, onCreate: (Database db, int version) async{
                        var query = await processSQLData();
                        await db.execute(query);
                      });

                    // Run insert query to database
                    await database.transaction((txn) async {
                      await txn.rawInsert('INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?)',
                      [journalEntryFields.title, journalEntryFields.body, journalEntryFields.rating, journalEntryFields.dateTime]);
                    });
                    
                    // Update state
                  setState((){
                    newSetting(false);
                    state.setState(() {
                    state.entries = false;
                      });
                              });
 

                    // Close database file
                    await database.close();
                    //Database.of(context).saveJournalEntry(journalEntryFields);
                    Navigator.of(context).pop();
            
                  }
                },
                child: Text('Submit'),
            )
          ]
       )
      ),
    );
  }

    void newSetting(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('entries', value);
  }
}
