import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/stores/stores.dart';

class CoronaSection extends StatefulWidget {
  const CoronaSection({Key key}) : super(key: key);
  @override
  _CoronaSectionState createState() => _CoronaSectionState();
}

class _CoronaSectionState extends State<CoronaSection>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  @override
  void initState() {
    Provider.of<CoronaStore>(context, listen: false).loadNepalData();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this, value: 0.7);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<CoronaStore>(
      builder: (BuildContext context, CoronaStore coronaStore, Widget child) {
        return StreamBuilder<CoronaCountrySpecificModel>(
          stream: coronaStore.nepalDataStream,
          builder: (BuildContext context,
              AsyncSnapshot<CoronaCountrySpecificModel> snapshot) {
            if (snapshot.hasData) {
              return _buildStatCard(snapshot, context);
            }
            return SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget _buildStatCard(
      AsyncSnapshot<CoronaCountrySpecificModel> snapshot, BuildContext context) {
    _controller.forward();
    return ScaleTransition(
      scale: _animation,
      child: Card(
        color: Colors.indigo,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        margin: const EdgeInsets.all(4),
        elevation: 2,
        child: InkWell(
          onTap: () => {},
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildDateTimeRow(snapshot, context),
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
                _buildCasesInfoRow(context, snapshot),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCasesInfoRow(
      BuildContext context, AsyncSnapshot<CoronaCountrySpecificModel> snapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildCaseItem(context, snapshot.data.todayCases, snapshot.data.cases,
            Colors.white, Colors.black, 'Oficially Confirmed'),
        _buildCaseItem(context, 0, snapshot.data.recovered, Colors.green[400],
            Colors.white, 'Recovered'),
        _buildCaseItem(context, snapshot.data.todayDeaths, snapshot.data.deaths,
            Colors.red[300], Colors.white, 'Deaths'),
      ],
    );
  }

  Widget _buildDateTimeRow(
      AsyncSnapshot<CoronaCountrySpecificModel> snapshot, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: snapshot.data.countryInfo.flag,
          width: 24,
          height: 24,
          placeholder: (context, url) => Icon(FontAwesomeIcons.spinner),
        ),
        RichText(
          text: TextSpan(
            text: snapshot.data.country,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            children: [
              TextSpan(
                text: '\t${snapshot.data.updated}',
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

  Widget _buildCaseItem(BuildContext context, int todayCases, int cases,
      Color higlightColor, Color textColor, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: higlightColor,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(30.0), right: Radius.circular(30.0))),
          child: Text(
            '+$todayCases',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: textColor),
          ),
        ),
        Text(
          '$cases',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: higlightColor,fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.caption.copyWith(
                color: higlightColor,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
