import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';

class ForexConverterItem extends StatelessWidget {
  const ForexConverterItem({
    Key key,
    @required this.selectedForexModel,
    @required this.controller,
    @required this.items,
    @required this.onChanged,
  }) : super(key: key);

  final ForexUIModel selectedForexModel;
  final TextEditingController controller;
  final List<ForexUIModel> items;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Image.network(
            selectedForexModel.forexEntity.currency.icon,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.error_outline,
              size: 24,
            ),
            width: 24,
            height: 24,
          ),
        ),
        Expanded(
          flex: 3,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              // icon: Icon(FontAwesomeIcons.sortDown),
              value: selectedForexModel.forexEntity.id,
              isExpanded: true,
              onChanged: onChanged,
              items: items
                  .map(
                    (entry) => DropdownMenuItem<String>(
                      value: entry.forexEntity.id,
                      child: Text(
                        entry.forexEntity.currency.title,
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
