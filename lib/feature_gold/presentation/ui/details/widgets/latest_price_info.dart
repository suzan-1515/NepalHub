import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_gold/presentation/models/gold_silver_model.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:scoped_model/scoped_model.dart';

class LatestPriceInfo extends StatelessWidget {
  const LatestPriceInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<GoldSilverUIModel>(
      builder: (context, child, model) => Text(
        '${model.entity.unit == 'tola' ? '1 tola' : '10 gms'}: ${model.entity.price.formattedString}',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
