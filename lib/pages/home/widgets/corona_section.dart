import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/home/widgets/corona_case_item.dart';
import 'package:samachar_hub/services/navigation_service.dart';

class CoronaSection extends StatefulWidget {
  final CoronaCountrySpecificModel data;
  const CoronaSection({Key key, this.data}) : super(key: key);
  @override
  _CoronaSectionState createState() => _CoronaSectionState();
}

class _CoronaSectionState extends State<CoronaSection>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        child: InkWell(
          onTap: () =>
              context.read<NavigationService>().toCoronaScreen(context),
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
            todayCases: widget.data.todayCases,
            cases: widget.data.cases,
            higlightColor: Colors.white,
            textColor: Colors.black,
            label: 'Oficially Confirmed'),
        CaseItem(
            context: context,
            todayCases: 0,
            cases: widget.data.recovered,
            higlightColor: Colors.green[400],
            textColor: Colors.white,
            label: 'Recovered'),
        CaseItem(
            context: context,
            todayCases: widget.data.todayDeaths,
            cases: widget.data.deaths,
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
        CachedNetworkImage(
          imageUrl: widget.data.countryInfo.flag,
          width: 24,
          height: 24,
          placeholder: (context, url) => Icon(FontAwesomeIcons.spinner),
        ),
        RichText(
          text: TextSpan(
            text: widget.data.country,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
            children: [
              TextSpan(
                text: '\t${widget.data.updated}',
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
