import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CoronaSection extends StatefulWidget {
  @override
  _CoronaSectionState createState() => _CoronaSectionState();
}

class _CoronaSectionState extends State<CoronaSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      color: Colors.blueGrey,
      child: Text(
        'This is a corona section',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
