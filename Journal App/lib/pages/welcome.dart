import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


// If there are no journal entries in app yet, this 'welcome'
// page will load instead
class Welcome extends StatelessWidget {
  final String apptitle = 'Welcome!';
 
  @override 
  Widget build(BuildContext context){
    return Center(
      child: Icon(Icons.book, size: 100.0),);
  }
}


