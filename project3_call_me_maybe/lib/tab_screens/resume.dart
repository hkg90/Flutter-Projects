import 'package:flutter/material.dart';
import 'package:project3_call_me_maybe/components/style.dart';

import '../models/file_data.dart';

// Generates Resume tab page for app and lists all jobs stored in Jobs Class
class MyResume extends StatelessWidget {
  static var allJobs = Jobs.data;
  
  @override 
  Widget build(BuildContext context){
    return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText('Denise Suter', Styles.textLarge),
                  nonBoldText('suterd@oregonstate.edu', Styles.textMed),
                  nonBoldText('https://github.com/hkg90', Styles.textMed),
                  for (var job in allJobs) 
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
        child: nonBoldText(description, Styles.textMed),
      ),
    ]);
}

// Style guideline for bolded text
Widget boldText(text, size){
  return Text(text, style: TextStyle(fontFamily: 'Abel', fontWeight: FontWeight.bold, fontSize: size));
}

// Style guideline for nonbolded text
Widget nonBoldText(text, size){
  return Text(text, style: TextStyle( fontFamily: 'Abel', fontSize: size));
}