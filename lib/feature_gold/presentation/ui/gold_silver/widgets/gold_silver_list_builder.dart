import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_gold/presentation/models/gold_silver_model.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/gold_silver/widgets/gold_silver_list_item.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/gold_silver/widgets/gold_silver_table_header.dart';
import 'package:scoped_model/scoped_model.dart';

class GoldSilverListBuilder extends StatelessWidget {
  const GoldSilverListBuilder({Key key, @required this.data})
      : assert(data != null, 'GoldSilver list cannot be null'),
        super(key: key);

  final List<GoldSilverUIModel> data;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: ListView.separated(
        itemCount: data.length + 1,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (_, index) {
          if (index == 0)
            return Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: GoldSilverTableHeader(context: context),
            );
          return ScopedModel<GoldSilverUIModel>(
            model: data[index - 1],
            child: GoldSilverListItem(
              context: context,
            ),
          );
        },
      ),
    );
  }
}
