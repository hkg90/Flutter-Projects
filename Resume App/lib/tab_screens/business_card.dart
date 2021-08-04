import 'package:flutter/material.dart';
import 'package:project3_call_me_maybe/components/single_row_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/single_row_text.dart';
import '../components/style.dart';

// Generates Business Card tab for app
class MyProfile extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return Scaffold(      
        body: 
            Column(
              children: [
                Flexible(
                  flex: 1,
                  child: 
                    FractionallySizedBox(
                      alignment: Alignment.center,
                      widthFactor: 0.5, 
                      heightFactor: 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(calcPadding(context)),
                        child: Image.asset('assets/profilePic.jpg')
                        )
                    )
                ),
                nonBoldText('Denise Suter', 40.0),
                nonBoldText('Student at OSU', Styles.textLarge),
                smsRow('888-888-8888'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    urlChild('https://github.com/hkg90'),
                    Flexible(flex: 1, 
                      child: SingleRowText(description: 'suterd@oregonstate.edu'),
                    )
                  ])
              ]
            )                 
    );
  }
}
 
// Creates bolded text widget
Widget boldText(text, size){
  return Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: size));
}

// Creates nonbolded text widget
Widget nonBoldText(text, size){
  return Text(text, style: TextStyle(fontSize: size));
}

// Allows for user to click on phone number on profile and open SMS messenger
Widget smsRow (description) {
  return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Flexible(flex: 1, 
                    child:  GestureDetector(
                      onTap: () => launch('sms: 8888888888'),
                      child: Text(description, style: new TextStyle(fontSize: 18),)
                    ), 
                  )
              ],
            );
}

// Allows for user to click on url on profile and open web broswer to that url
Widget urlChild (description) {
  return Flexible(flex: 1, 
      child:  GestureDetector(
        onTap: () => launch('https://github.com/hkg90'),
        child: Text(description, style: new TextStyle(fontSize: 16))
      ), 
    );

}

// Determines padding for when phone is horizontal or vertical
double calcPadding(BuildContext context){
  if (MediaQuery.of(context).orientation == Orientation.landscape){
    return MediaQuery.of(context).size.width * 0.001;
  }
  return MediaQuery.of(context).size.width * 0.01;
}
