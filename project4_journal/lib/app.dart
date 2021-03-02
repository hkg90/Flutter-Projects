import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:project4_journal/pages/display_single_entry.dart';
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
  var entries = 0;
  var userJournal;
  static const THEME_SETTING_KEY = 'theme';
  static const ENTRIES_KEY = 'entries';


  // Getter for retreiving current preferences saved theme value (if no value saved, default to True)
  bool get themeSetting => widget.preferences.getBool(THEME_SETTING_KEY) ?? true;

  // Getter for retreiving current preferences saved theme value (if no value saved, default to 0)
  int get entriesSetting => widget.preferences.getInt(ENTRIES_KEY) ?? 0;
  
  void initState(){
    super.initState();
    // Will determine number of entries currently written in journal. If 0, 
    // welcome page will load, else journal entries page will load
    loadJournal();
  }

  // Loads journal data from sqflite database
  void loadJournal() async {   
    // Open database file
    Database database = await openDatabase(
      'journal.sqlite3.db', version: 1, onCreate: (Database db, int version) async{
        var query = await processSQLData();
        await db.execute(query);
      });
  
    // Retrieve data from sql database
    List<Map> databaseEntries = await database.rawQuery('SELECT * FROM journal_entries');

    // Create journal object to store database entries into a list
    final listEntries = databaseEntries.map((record){
      return Entries(
        title: record['title'],
        body: record['body'], 
        rating: record['rating'],
        dateTime: DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(record['date'])));
    }).toList();
    
    // Set state for journal
    setState(() {
      userJournal = listEntries;   
    });
  }

  // Notifier variable, if variable value is changed UI theme will update
  ValueNotifier<bool> themeState = ValueNotifier<bool>(true);

  // Notifier variable, if variable value is changed page will switch from 'welcome'
  // display to list of journal entries
  ValueNotifier<int> entriesState = ValueNotifier<int>(0);
  
  // Updates theme setting notifier value and sets new theme state
  void updateSetting(BuildContext context, Color newColor) {
  AppState state = context.findAncestorStateOfType<AppState>();
   state.setState(() {
     state.theme = widget.preferences.getBool(THEME_SETTING_KEY);
    });
  themeState = ValueNotifier<bool>(state.theme);
  }

  // Updates entries setting notifier value and sets new entries state
  void updateEntries(BuildContext context) {
  AppState state = context.findAncestorStateOfType<AppState>();
   state.setState(() {
     state.entries = widget.preferences.getInt(ENTRIES_KEY);
    });
  entriesState = ValueNotifier<int>(state.entries);
  }

  @override
  Widget build(BuildContext context) {
    // Value Listenable builder rebuilds widgets if themeState and/ or entries State 
    // value notifier variable's value is changed
    return ValueListenableBuilder(
      builder: (BuildContext context, int entriesState, Widget child) {
        return ValueListenableBuilder(
        builder: (BuildContext context, bool themeState, Widget child) {
          return MaterialApp(
            // Determmines title display text
            title: (entriesSetting == 0)? 'Welcome!' : 'Journal Entries',
            // Determines theme of app
            theme: themeSetting ? ThemeData.light(): ThemeData.dark(),
            home: Builder(
                        builder: (context) {
                          return new Scaffold(
          // Adds settings drawer
          endDrawer: SettingsDrawer(),
          appBar: 
          AppBar(
              // Determmines title display text
              title: Text((entriesSetting == 0)? 'Welcome!' : 'Journal Entries'),
              actions: [Builder( builder: (context) =>
              // Designates icon for settings drawer
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
              ),]
          ),
          body: 
            // Determines which page to display (welcome or list of entries)
            (entriesSetting == 0) ? Welcome(): JournalEntries(),
            // Contains widget for floating action new journal entry form button
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add_circle_outline),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewEntry()));
              }
            )
          );} 
        )
      );},
        valueListenable: themeState,      
      );},
      valueListenable: entriesState,
    );
  }




}

