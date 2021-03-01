import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project4_journal/app.dart';

// Navigation Drawer that holds Dark Mode option for user to select
class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({Key key}) : super(key: key);

  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  bool _lightTheme = false;

  

  @override
  Widget build(BuildContext context) {
  AppState state = context.findAncestorStateOfType<AppState>();
  
  return Drawer(
     child: ListView(
       padding: new EdgeInsets.all(0.0),
       children: <Widget>[
        Container(
          height: 120.0,
          child: DrawerHeader(
              child: Text('Settings')
              ),
        ),
        SwitchListTile(
            title: const Text('Dark Mode'),
            value: _lightTheme, 
            onChanged: (bool value) {
            setState((){
              _lightTheme = value;
              newSetting(value);
              state.setState(() {
              state.theme = value;
    });
            });
          })
       ],
       
       )
    );
  }


  void newSetting(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', value);
  }
}
  
     
     
     
//      Column(
//     // Important: Remove any padding from the ListView.
//    // crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [
    
      
    
//               DrawerHeader(
//           child: 
// Text('Settings'),      
//         ),
     
                
//     ],
//   ),);
//     );
//   }
// }

