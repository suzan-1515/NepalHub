import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/forex/widgets/forex_converter.dart';
import 'package:samachar_hub/pages/forex/widgets/forex_list_item.dart';
import 'package:samachar_hub/pages/forex/widgets/forex_table_header.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/stores/stores.dart';

class ForexList extends StatelessWidget {
  const ForexList({
    Key key,
    @required this.context,
    @required this.store,
  }) : super(key: key);

  final BuildContext context;
  final ForexStore store;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ForexModel>>(
      stream: store.dataStream,
      builder: (_, AsyncSnapshot<List<ForexModel>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorDataView(
              onRetry: () => store.retry(),
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: EmptyDataView(),
            );
          }
          return ListView.separated(
              itemCount: snapshot.data.length + 1,
              separatorBuilder: (_, index) {
                return Observer(
                  builder: (_) {
                    ForexModel defaultForex = store.defaultForex;
                    if (index == 1) {
                      if (defaultForex != null) {
                        return ForexConverter(
                            items: snapshot.data,
                            defaultForex: defaultForex,
                            store: store);
                      }
                    }
                    return Divider();
                  },
                );
              },
              itemBuilder: (_, index) {
                if (index == 0)
                  return Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: ForexTableHeader(context: context));
                return ForexListItem(
                  context: context,
                  data: snapshot.data[index - 1],
                );
              });
        } else {
          return Center(child: ProgressView());
        }
      },
    );
  }
}
