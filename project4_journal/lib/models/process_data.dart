// Processes data from database by creating DTOs and processing
// input file to create database table schema
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


const SQL_FILE = 'assets/schema_1.sql.txt';

//Model Class for Journal entry data
class Entries{
  final String title;
  final String body;
  final rating;
  final dateTime;

// Job constructor
  Entries({this.title, this.body, this.rating, this.dateTime});
}

//Retreieves and returns database initialization schema to establish database 
// table (if one does not already exist)
Future processSQLData() async {
  // Loads sql command from schema_1.sql.txt file
  var contents = await rootBundle.loadString(SQL_FILE);  
  return contents;
}