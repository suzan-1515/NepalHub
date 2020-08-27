import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/data/models/models.dart';

class ForexConverterItem extends StatelessWidget {
  const ForexConverterItem({
    Key key,
    @required this.currencyCode,
    @required this.currency,
    @required this.controller,
    @required this.items,
    @required this.onChanged,
  }) : super(key: key);

  final String currencyCode;
  final String currency;
  final TextEditingController controller;
  final List<ForexModel> items;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SvgPicture.network(
            'https://www.ashesh.com.np/forex/flag/$currencyCode.svg',
            placeholderBuilder: (_) {
              return Container(
                width: 24,
                height: 24,
                color: Theme.of(context).cardColor,
              );
            },
            width: 24,
            height: 24,
          ),
        ),
        Expanded(
          flex: 3,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              // icon: Icon(FontAwesomeIcons.sortDown),
              value: currencyCode,
              isExpanded: true,
              onChanged: onChanged,
              items: items
                  .map(
                    (entry) => DropdownMenuItem<String>(
                      value: entry.code,
                      child: Text(
                        entry.currency,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 2,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: controller,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}
