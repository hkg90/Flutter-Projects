import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project4_journal/pages/new_entry.dart';
import 'package:project4_journal/pages/setting.dart';
import 'package:project4_journal/app.dart';



class Welcome extends StatelessWidget {
  final String apptitle = 'Welcome!';

 
  @override 
  Widget build(BuildContext context){
    return Center(
      child: Icon(Icons.book, size: 100.0),);
  }
}


