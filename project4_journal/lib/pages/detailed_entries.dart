import 'package:project4_journal/models/process_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Generates Resume tab page for app and lists all jobs stored in Jobs Class
class DetailedJournalEntries extends StatefulWidget {
  static var allJobs = JobEntries.data;

  @override
  DetailedJournalEntriesState createState() => DetailedJournalEntriesState();
}

class DetailedJournalEntriesState extends State<DetailedJournalEntries> {
  @override 
  Widget build(BuildContext context){
    return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var job in DetailedJournalEntries.allJobs) 
                    jobRow(job.title, job.company, job.date, job.location, job.description)
              ],)
            );
  }
}
 
// Creates section for each job from Jobs Class 
Widget jobRow (title, company, date, location, description) { 
  return Column(
    mainAxisSize: MainAxisSize.min,    
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,   
    children: [
      // Job title
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: boldText(title, 18.0),
      ), 
      // Job company, date, location
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible( flex: 1, child: boldText(company, 15.0)),
            Flexible( flex: 3, child: boldText(date, 15.0)),
            Flexible( flex: 1, child: boldText(location, 15.0)),
          ],
        ),
      ),
      // Job description
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: nonBoldText(description, 'medium'),
      ),
    ]);
}

// Style guideline for bolded text
Widget boldText(text, size){
  return Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: size));
}

// Style guideline for nonbolded text
Widget nonBoldText(text, size){
  return Text(text, style: TextStyle( fontSize: size));
}