import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:project4_journal/pages/detailed_entries.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sqflite/sqflite.dart';
import 'pages/welcome.dart';
import 'pages/entries.dart';
import 'package:project4_journal/models/process_data.dart';
import 'package:project4_journal/pages/setting.dart';
import 'package:project4_journal/pages/new_entry.dart';



class App extends StatefulWidget  {
  // This widget is the root of the application.
  final SharedPreferences preferences;

  App({Key, key, @required this.preferences}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  
  var theme = true;
  var entries = true;
  var userJournal;
  static const THEME_SETTING_KEY = 'theme';
  static const ENTRIES_KEY = 'entries';


  // Getter for retreiving current preferences saved theme value (if no value saved, default to True)
  bool get themeSetting => widget.preferences.getBool(THEME_SETTING_KEY) ?? true;

  // Getter for retreiving current preferences saved theme value (if no value saved, default to True)
  bool get entriesSetting => widget.preferences.getBool(ENTRIES_KEY) ?? true;
  
  void initState(){
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    // TODO: Delete this code later: Code to reset preferences
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    //await preferences.clear();
    
    // Delete database
    //await deleteDatabase('jounal.db'); 
    
    // Open database file
    Database database = await openDatabase(
      'journal.db', version: 1, onCreate: (Database db, int version) async{
        var query = await processSQLData();
        await db.execute(query);
      });

    //await deleteDatabase('jounal.db');    
    
    // Retrieve data from sql database
    List<Map> databaseEntries = await database.rawQuery('SELECT * FROM journal_entries');
    
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    // Create journal object to store database entries in a list
    final listEntries = databaseEntries.map((record){
      return Entries(
        title: record['title'],
        body: record['body'], 
        rating: record['rating'],
        dateTime: formatter.format(DateTime.parse(record['date'])));
    }).toList();
    
    setState(() {
      // Journal.journal = listEntries; 
      userJournal = listEntries;
      print(userJournal);
    });
  }

  // Notifier variable, if variable value is changed UI theme will update
  ValueNotifier<bool> themeState = ValueNotifier<bool>(true);

  // Notifier variable, if variable value is changed UI theme will update
  ValueNotifier<bool> entriesState = ValueNotifier<bool>(true);
  
  // Updates theme setting notifier value and sets new theme state
  void updateSetting(BuildContext context, Color newColor) {
  AppState state = context.findAncestorStateOfType<AppState>();
   state.setState(() {
     state.theme = widget.preferences.getBool(THEME_SETTING_KEY);
    });
  themeState = ValueNotifier<bool>(state.theme);
  }

  // Updates theme setting notifier value and sets new theme state
  void updateEntries(BuildContext context) {
  AppState state = context.findAncestorStateOfType<AppState>();
   state.setState(() {
     state.entries = widget.preferences.getBool(ENTRIES_KEY);
    });
  entriesState = ValueNotifier<bool>(state.entries);
  }

  @override
  Widget build(BuildContext context) {
    // Value Listenable builder rebuilds widgets if themeState value notifier variable's value
    // is changed
    return ValueListenableBuilder(
      builder: (BuildContext context, bool themeState, Widget child) {
        return MaterialApp(
          title: entriesSetting? 'Welcome!' : 'Journal Entries',
          // Determines theme of app
          theme: themeSetting ? ThemeData.light(): ThemeData.dark(),
          home: Builder(
                      builder: (context) {
                        return new Scaffold(
        endDrawer: SettingsDrawer(),
        appBar: 
        AppBar(
            title: Text(entriesSetting? 'Welcome!' : 'Journal Entries'),
            actions: [Builder( builder: (context) =>
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
            ),]
        ),
        body: entriesSetting ? Welcome(): JournalEntries(),
                floatingActionButton: FloatingActionButton(
                      child: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewEntry()));
                      }
              )
            );
                      } 
          )
        );
      },
      valueListenable: themeState,
          
    );
  }




}

