import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:project4_journal/models/process_data.dart';
import 'package:flutter/material.dart';
import 'package:project4_journal/pages/display_single_entry.dart';
import 'package:flutter/widgets.dart';
import 'package:project4_journal/app.dart';


// Generates Resume tab page for app and lists all jobs stored in Jobs Class
class JournalEntries extends StatefulWidget {
  // final recordObject;

  // JournalEntries({Key key, @required this.recordObject}) : super(key: key);
  @override
  JournalEntriesState createState() => new JournalEntriesState();
}

class JournalEntriesState extends State<JournalEntries> {
 
  var userJournal;
  final String apptitle = 'Journal Entries';
  

  // Used to initalize entries display page with journal entries from database
  void initState(){
    super.initState();
    loadJournal();
  }
  
  Future loadJournal() async {
    // Open database file
    Database database = await openDatabase(
      'journal.sqlite3.db', version: 1, onCreate: (Database db, int version) async{
        var query = await processSQLData();
        await db.execute(query);
      });
    
    // Retrieve data from sql database
    List<Map> databaseEntries = await database.rawQuery('SELECT * FROM journal_entries');
    
    // final DateFormat formatter = DateFormat('yyyy-MM-dd');

    // Create journal object to store database entries in a list
    final listEntries = databaseEntries.map((record){
      return Entries(
        title: record['title'],
        body: record['body'], 
        rating: record['rating'],
        dateTime: DateFormat.yMMMd().format(DateTime.parse(record['date'])));
      }).toList();
    
    setState(() {
      // Journal.journal = listEntries; 
      userJournal = listEntries;
      print('entries.dart side: ');
      print(userJournal);
      return userJournal;
    });
  }

  @override 
  void didUpdateWidget(JournalEntries oldWidget) {
    super.didUpdateWidget(oldWidget);
    loadJournal();
  }
  Widget build(BuildContext context){
    
    return LayoutBuilder(builder: layoutDecider,);
  }

  Widget layoutDecider (BuildContext context, BoxConstraints constraints) =>
  constraints.maxWidth < 500? verticalLayout1(context) : horizontalLayout(context);

  // Widget pageDecider (BuildContext context, userJournal) =>
  // userJournal

//var userJournal = loadJournal();
  Widget verticalLayout1(BuildContext context)  {
    
    
    return (userJournal == null ) ? loadPage(context) : loadList(context);      
      
    
  } 

  Widget loadList(BuildContext context){
    var count = userJournal.length;
      return ListView.separated(
        itemCount: count,
        separatorBuilder:  (BuildContext context, int index) => Divider(), 
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
          title: Text(userJournal[index].title),
          subtitle: Text(userJournal[index].body+', ' + userJournal[index].dateTime.toString()),
          onTap: () {Navigator.push(
              context, MaterialPageRoute(builder: (context) {
                
                return DetailedEntries(newEntry: userJournal[index]);
              } 
              ),
          );},
          );
        });
    
    }



   Widget verticalLayout2(BuildContext context){
    //var userJournal = loadJournal();
    AppState state = context.findAncestorStateOfType<AppState>();
    return ListView.separated(
        itemCount: state.entries != null ? 1: 2,
        separatorBuilder:  (BuildContext context, int index) => Divider(), 
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
          title: Text(userJournal[index].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
          subtitle: Text('Rating: ' + userJournal[index].rating.toString()+ '\n' + userJournal[index].body),
          
          );
        });      
      
    
  } 


 Future horizontalLayout(BuildContext context)async {
  
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     children: [
        Expanded(
                  child: await verticalLayout1(context)
        ),
     Expanded(
            child: verticalLayout2(context)
     )
    ]);  
  }
  Widget loadPage(BuildContext context){
    
      return Column(
        children: [
            Text('Loading'),
            Center(child: CircularProgressIndicator(),)
        ],);
    
    }


  

}

