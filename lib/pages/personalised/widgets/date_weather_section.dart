import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DateWeatherSection extends StatefulWidget {
  @override
  _DateWeatherSectionState createState() => _DateWeatherSectionState();
}

class _DateWeatherSectionState extends State<DateWeatherSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(8),
      color: Colors.blue,
      child: Text(
        'This is a date section',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
