import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'components/style.dart';
import 'tab_screens/business_card.dart';
import 'tab_screens/predictor.dart';
import 'tab_screens/resume.dart';


class App extends StatelessWidget  {
  // This widget is the root of the application.
  final String apptitle = 'Call Me Maybe';
  
  // // Invokes parent constructor
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Styles.appTheme,
      home: DefaultTabController(
        length: 3, 
        child: Scaffold(
          appBar: AppBar(
            title: Text(apptitle),
            bottom: TabBar(
              // Contains icons for each tab in app bar
              tabs: [
                Tab(icon: Icon(Icons.badge)),
                Tab(icon: Icon(Icons.assignment_outlined)),
                Tab(icon: Icon(Icons.auto_awesome)),
              ],
            ),
          ),
          body: TabBarView(
            // Contains page views for each tab
            children: [
              MyProfile(),
              MyResume(),
              Fortune(),
            ],
          ),
        )
      )
    );
  }
}