import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';


const DATA_FILE = 'assets/resume.json';
const SQL_FILE = 'assets/schema_1.sql.txt';

// Model Class for Journal
class Journal{
  static var entries = [];
  static var journal;
  
  bool isEmpty(journal){
    return journal.isEmpty;
  }
  
}

//Model Class for Journal entry data
class Entries{
  final String title;
  final String body;
  final rating;
  final dateTime;

// Job constructor
  Entries({this.title, this.body, this.rating, this.dateTime});
}

// Model Class for Call Me Maybe app that stores all job data
class JobEntries {
  final  title;
  final String company;
  final String date;
  final String location;
  final String description;
  static var data = [];
  
  // Job constructor
  JobEntries({this.title, this.company, this.date, this.location, this.description});
}

// Creates a Job object for each one listed in JSON file and adds new job
// to Jobs class (stored in 'data' array variable)
void createJobs(resumeData){
  resumeData.forEach( (entry) {
    var newJob = JobEntries(title: entry['job title'], company: entry['company'], date: entry['date'], location: entry['location'], description: entry['description']);
    JobEntries.data.add(newJob);
  });
}

//Gets data from JSON specified file 
Future processData() async {
  var contents = await rootBundle.loadString(DATA_FILE);  
  var resumeData = json.decode(contents);

  // Convert data into Jobs class members
  createJobs(resumeData);
}

//Gets sql query from specified file 
Future processSQLData() async {
  var contents = await rootBundle.loadString(SQL_FILE);  
  //var resumeData = json.decode(contents);

  return contents;
}