import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:project4_journal/pages/setting.dart';


// Widget to display single detailed journal entry (title, body, rating, date)
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
                Scaffold.of(context).openEndDrawer();},
              ),
            ),]
          ),
          body: ListView.separated(
            itemCount: 1,
            separatorBuilder:  (BuildContext context, int index) => Divider(), 
            itemBuilder: (BuildContext context, int index) {
            // Creates listtile widget displaying detailed journal entry information (title, body, rating)
            return ListTile(
              title: Text(newEntry.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),),
              subtitle: Text(newEntry.body + '\n' + 'Rating: ' + newEntry.rating.toString(), style: TextStyle(fontSize: 18)),
              );
          }) 
        );
      } 
    );
  }

}
