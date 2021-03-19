import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


// Model Class for Call Me Maybe app that stores all job data
class Jobs {
  final String title;
  final String company;
  final String date;
  final String location;
  final String description;
  static var data = [];
  
  // Job constructor
  Jobs({this.title, this.company, this.date, this.location, this.description});
}

// Creates a Job object for each one listed in JSON file and adds new job
// to Jobs class (stored in 'data' array variable)
void createJobs(resumeData){
  resumeData.forEach( (entry) {
    var newJob = Jobs(title: entry['job title'], company: entry['company'], date: entry['date'], location: entry['location'], description: entry['description']);
    Jobs.data.add(newJob);
  });
}

// Gets data from JSON specified file 
Future processData() async {
  // Reference source: I read through this article to determine how to read a .json file and decode its contents
  // https://stackoverflow.com/questions/49757953/how-to-load-json-assets-into-flutter-app and adjusted the code
  // to pull the .json file I stored my job data in.
  var contents = await rootBundle.loadString('assets/resume.json');  
  var resumeData = json.decode(contents);

  // Convert data into Jobs class members
  createJobs(resumeData);
}
