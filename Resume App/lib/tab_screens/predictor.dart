import 'package:flutter/material.dart';
import '../models/random.dart';


// Generates stateful widget for Predictor tab page
class Fortune extends StatefulWidget {
  State createState() => FortuneTelling();
}

// Creates random fortunes each time user clicks on "Ask a question... Tap for an answer" text
class FortuneTelling extends State<Fortune> {
  var fate="Let's find out"; //Initial value for fate

  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Call Me... Maybe?', 
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontSize: 40.0,
        )),
        
        // Generates response from random.dart model, RandomFate class
        Padding(padding: EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () {setState(() {
            fate = RandomFate().testFate();
          });},
          child: 
            Text('Ask a question... Tap for an answer.', 
            style: Theme.of(context).textTheme.headline6,),
          )
        ),

        Flexible( flex: 1,
        child: 
          Text('$fate', 
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              //Reference source: To make the gradient I utilized the code example in this stack overflow
              // post: https://stackoverflow.com/questions/51686868/gradient-text-in-flutter . I modified the 
              // style to fit with my project.
              foreground: Paint()..shader = linearGradient
            )
          )
        ),
      ]);
  }
}

//Reference source: To make the gradient I utilized the code example in this stack overflow
// post: https://stackoverflow.com/questions/51686868/gradient-text-in-flutter . I modified the 
// code to fit my design and style for this project.
final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.yellow, Colors.orange[800], Colors.red[900]],
).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 50.0));