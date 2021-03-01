import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:project4_journal/models/process_data.dart';
import 'package:flutter/material.dart';
import 'package:project4_journal/pages/display_single_entry.dart';
import 'package:flutter/widgets.dart';


// Generates Resume tab page for app and lists all jobs stored in Jobs Class
class JournalEntries extends StatefulWidget {
  static var allJobs = JobEntries.data;


  @override
  JournalEntriesState createState() => JournalEntriesState();
}

class JournalEntriesState extends State<JournalEntries> {
  var userJournal;
  final String apptitle = 'Journal Entries';


  void initState(){
    super.initState();
    //loadJournal();
  }
  
  Future loadJournal() async {
    // Open database file
    Database database = await openDatabase(
      'journal.db', version: 1, onCreate: (Database db, int version) async{
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
      print(userJournal);
      return userJournal;
    });
  }

  @override 
  Widget build(BuildContext context){
    return LayoutBuilder(builder: layoutDecider);
  }

  Widget layoutDecider (BuildContext context, BoxConstraints constraints) =>
  constraints.maxWidth < 500? verticalLayout1(context, userJournal) : horizontalLayout(context, userJournal);


  Widget verticalLayout1(BuildContext context, userJournal){
    //var userJournal = loadJournal();
    return ListView.separated(
        itemCount: loadJournal() == null ? loadPage(context): userJournal.length,
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

   Widget verticalLayout2(BuildContext context, userJournal){
    //var userJournal = loadJournal();
    return ListView.separated(
        itemCount: loadJournal() == null ? loadPage(context): userJournal.length,
        separatorBuilder:  (BuildContext context, int index) => Divider(), 
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
          title: Text(userJournal[index].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
          subtitle: Text('Rating: ' + userJournal[index].rating.toString()+ '\n' + userJournal[index].body),
          
          );
        });      
      
    
  } 


 Widget horizontalLayout(BuildContext context, userJournal){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     children: [
        Expanded(
                  child: verticalLayout1(context, userJournal)
        ),
     Expanded(
            child: verticalLayout2(context, userJournal)
     )
    ]);  
  }
  Widget loadPage(BuildContext context){
    if (JournalEntriesState().userJournal == null){
      return Column(
        children: [
            Text('Loading'),
            Center(child: CircularProgressIndicator(),)
        ],);
    } else {
      return LayoutBuilder(builder: layoutDecider);
    }


  }

}

