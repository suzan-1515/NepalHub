import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';

class DateWeatherSection extends StatefulWidget {
  @override
  _DateWeatherSectionState createState() => _DateWeatherSectionState();
}

class _DateWeatherSectionState extends State<DateWeatherSection>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: RichText(
              text: TextSpan(
                text: NepaliDateFormat("d MMMM yyyy, EEE")
                    .format(NepaliDateTime.now()), //'२ जेष्ठ २०७७, शुक्रवार'
                style: Theme.of(context).textTheme.subtitle1,
                children: <TextSpan>[
                  TextSpan(
                      text:
                          '\n${DateFormat("d MMMM y, EEEE").format(DateTime.now())}', //'\n15 May 2020'
                      style: Theme.of(context).textTheme.bodyText2)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
