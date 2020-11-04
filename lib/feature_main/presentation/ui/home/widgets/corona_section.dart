import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/domain/entities/home_entity.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/corona_case_item.dart';

class CoronaSection extends StatelessWidget {
  final CoronaEntity data;
  const CoronaSection({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      duration: const Duration(milliseconds: 300),
      child: Card(
        color: Colors.indigo,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        margin: const EdgeInsets.all(4),
        elevation: 2,
        child: InkWell(
          onTap: () => GetIt.I.get<NavigationService>().toCoronaScreen(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildDateTimeRow(context),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Coronavirus\nRealtime Updates',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(
                  height: 8,
                ),
                _buildCasesInfoRow(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCasesInfoRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CaseItem(
            context: context,
            todayCases: int.parse(data.coronaCase),
            cases: int.parse(data.totalCases),
            higlightColor: Colors.white,
            textColor: Colors.black,
            label: 'Oficially Confirmed'),
        CaseItem(
            context: context,
            todayCases: int.parse(data.recovered),
            cases: int.parse(data.totalRecovered),
            higlightColor: Colors.green[400],
            textColor: Colors.white,
            label: 'Recovered'),
        CaseItem(
            context: context,
            todayCases: int.parse(data.death),
            cases: int.parse(data.totalDeaths),
            higlightColor: Colors.red[300],
            textColor: Colors.white,
            label: 'Deaths'),
      ],
    );
  }

  Widget _buildDateTimeRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TransitionToImage(
          image: AdvancedNetworkImage(
            data.country.flag,
            width: 24,
            height: 24,
          ),
          width: 24,
          height: 24,
        ),
        RichText(
          text: TextSpan(
            text: data.country.title,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
            children: [
              TextSpan(
                text: '\t${DateFormat.yMd().add_jm().format(data.lastUpdated)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
