import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CoronaSection extends StatefulWidget {
  @override
  _CoronaSectionState createState() => _CoronaSectionState();
}

class _CoronaSectionState extends State<CoronaSection> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      margin: const EdgeInsets.all(4),
      elevation: 2,
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(8),
        child: Text(
          'This is a corona section',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
