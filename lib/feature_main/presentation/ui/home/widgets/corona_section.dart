import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/feature_main/presentation/extensions/home_extensions.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/corona_model.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/corona_case_item.dart';

class CoronaSection extends StatefulWidget {
  final CoronaUIModel data;

  const CoronaSection({Key key, this.data}) : super(key: key);

  @override
  _CoronaSectionState createState() => _CoronaSectionState();
}

class _CoronaSectionState extends State<CoronaSection>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ZoomIn(
      duration: const Duration(milliseconds: 300),
      child: Card(
        color: Colors.indigo,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        margin: const EdgeInsets.all(4),
        elevation: 2,
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
    );
  }

  Widget _buildCasesInfoRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CaseItem(
            context: context,
            todayCases: int.parse(widget.data.coronaEntity.coronaCase),
            cases: int.parse(widget.data.coronaEntity.totalCases),
            higlightColor: Colors.white,
            textColor: Colors.black,
            label: 'Oficially Confirmed'),
        CaseItem(
            context: context,
            todayCases: int.parse(widget.data.coronaEntity.recovered),
            cases: int.parse(widget.data.coronaEntity.totalRecovered),
            higlightColor: Colors.green[400],
            textColor: Colors.white,
            label: 'Recovered'),
        CaseItem(
            context: context,
            todayCases: int.parse(widget.data.coronaEntity.death),
            cases: int.parse(widget.data.coronaEntity.totalDeaths),
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
        CachedImage(
          widget.data.coronaEntity.country.flag,
          width: 24,
          height: 24,
        ),
        RichText(
          text: TextSpan(
            text: widget.data.coronaEntity.country.title,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
            children: [
              TextSpan(
                text:
                    '\t${widget.data.coronaEntity.lastUpdated.formattedString}',
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

  @override
  bool get wantKeepAlive => true;
}
