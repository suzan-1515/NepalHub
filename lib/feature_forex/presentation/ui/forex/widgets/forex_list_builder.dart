import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex/widgets/forex_converter.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex/widgets/forex_list_item.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex/widgets/forex_table_header.dart';
import 'package:scoped_model/scoped_model.dart';

class ForexListBuilder extends StatelessWidget {
  const ForexListBuilder(
      {Key key, @required this.data, @required this.defaultForex})
      : assert(data != null, 'Forex list cannot be null'),
        assert(defaultForex != null, 'Default forex cannot be null'),
        super(key: key);

  final List<ForexUIModel> data;
  final ForexUIModel defaultForex;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: ListView.separated(
        itemCount: data.length + 1,
        separatorBuilder: (_, index) {
          if (index == 1) {
            return ForexConverter(
              items: data,
              defaultForex: defaultForex,
            );
          }
          return Divider();
        },
        itemBuilder: (_, index) {
          if (index == 0)
            return Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: ForexTableHeader(context: context),
            );
          return ScopedModel<ForexUIModel>(
            model: data[index - 1],
            child: ForexListItem(
              context: context,
            ),
          );
        },
      ),
    );
  }
}
