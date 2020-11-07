import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';
import 'package:scoped_model/scoped_model.dart';

class LatestRateInfo extends StatelessWidget {
  const LatestRateInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ForexUIModel>(
      builder: (context, child, model) => Text(
        'Buy: ${model.entity.buying} Sell: ${model.entity.selling}',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
