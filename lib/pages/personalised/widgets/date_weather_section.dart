import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DateWeatherSection extends StatefulWidget {
  @override
  _DateWeatherSectionState createState() => _DateWeatherSectionState();
}

class _DateWeatherSectionState extends State<DateWeatherSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '२ जेष्ठ २०७७, शुक्रवार',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1,
                children: <TextSpan>[
                  TextSpan(
                      text: '\n15 May 2020',
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
