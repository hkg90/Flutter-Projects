import 'package:flutter/material.dart';


// Used to create basic idea/layout for app pages. Boxes act as placeholder
// until replaced with actual code to meet layout requirements
class CenteredPlaceholder extends StatelessWidget {
  
  final double padding;

  const CenteredPlaceholder({Key key, this.padding}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Placeholder(),
      )
    );
  }
}