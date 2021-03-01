import 'package:project4_journal/models/process_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project4_journal/pages/setting.dart';


class DetailedEntries extends StatelessWidget {
final newEntry;

DetailedEntries ({this.newEntry});
 @override 
  Widget build(BuildContext context){
    
    return Builder(
                      builder: (context) {
                        return new Scaffold(
        endDrawer: SettingsDrawer(),
        appBar: 
        AppBar(
            title: Text(newEntry.dateTime),
            actions: [Builder( builder: (context) =>
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
            ),]
        ),
        body: ListView.separated(
        itemCount: 1,
        separatorBuilder:  (BuildContext context, int index) => Divider(), 
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
          title: Text(newEntry.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
          subtitle: Text('Rating: ' + newEntry.rating.toString() + '\n' + newEntry.body),
          
          );
        }) 
            );
                      } 
          );
  }

}


// class DetailedEntries extends StatefulWidget {
//   final clickedEntry;

//   Entries getEntry (){
//     return clickedEntry;
//   }

//   DetailedEntries ({this.clickedEntry});

//   @override
//   DetailedEntriesState createState() => DetailedEntriesState();
// }

// class DetailedEntriesState extends State<DetailedEntries> {
//   static const ENTRIES_KEY = 'entries';

  
  

//   @override 
//   Widget build(BuildContext context){
//     var newEntry = DetailedEntries().getEntry();
//     return Builder(
//                       builder: (context) {
//                         return new Scaffold(
//         endDrawer: SettingsDrawer(),
//         appBar: 
//         AppBar(
//             title: Text(newEntry.dateTime),
//             actions: [Builder( builder: (context) =>
//             IconButton(
//               icon: const Icon(Icons.settings),
//               onPressed: () {
//                 Scaffold.of(context).openEndDrawer();
//               },
//             ),
//             ),]
//         ),
//         body: ListView.separated(
//         itemCount: 1,
//         separatorBuilder:  (BuildContext context, int index) => Divider(), 
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//           title: Text(DetailedEntries().clickedEntry.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
//           // subtitle: Text(DetailedEntries().clickedEntry.body+', ' + DetailedEntries().clickedEntry.dateTime.toString()),
          
//           );
//         }) 
//             );
//                       } 
//           );
//   }
// }
 