import 'package:flutter/material.dart';

// Widget creates a row that displays one child with a text description/ line
class SingleRowText extends StatelessWidget {
  
  final String description;

  const SingleRowText({Key key, this.description}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: SizedBox(
                    child: Text(description, style: new TextStyle(fontSize: 16),),
                  )
                )
              ],
            );
  }
}