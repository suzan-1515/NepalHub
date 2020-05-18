import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/store/corona_store.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';

class CoronaSection extends StatefulWidget {
  const CoronaSection({Key key}) : super(key: key);
  @override
  _CoronaSectionState createState() => _CoronaSectionState();
}

class _CoronaSectionState extends State<CoronaSection> with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    Provider.of<CoronaStore>(context,listen: false).loadNepalData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      color: Colors.indigo,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      margin: const EdgeInsets.all(4),
      elevation: 2,
      child: InkWell(
        onTap: () => {},
        child: Consumer<CoronaStore>(
          builder: (BuildContext context, CoronaStore coronaStore,
              Widget child) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: StreamBuilder<CoronaCountrySpecific>(
                stream: coronaStore.nepalDataStream,
                builder: (BuildContext context,
                    AsyncSnapshot<CoronaCountrySpecific> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: ErrorDataView(),
                    );
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return Center(child: EmptyDataView());
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: snapshot.data.countryInfo.flag,
                              width: 24,
                              height: 24,
                              placeholder: (context, url) => Icon(Icons.image),
                            ),
                            RichText(
                              text: TextSpan(
                                text: snapshot.data.country,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
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
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Coronavirus\nRealtime Updates',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildCase(
                                context,
                                snapshot.data.todayCases,
                                snapshot.data.cases,
                                Colors.red[400],
                                Colors.white,
                                'Oficially Confirmed'),
                            _buildCase(
                                context,
                                0,
                                snapshot.data.recovered,
                                Colors.green[400],
                                Colors.white,
                                'Recovered'),
                            _buildCase(
                                context,
                                snapshot.data.todayDeaths,
                                snapshot.data.deaths,
                                Colors.white,
                                Colors.black,
                                'Deaths'),
                          ],
                        ),
                      ],
                    );
                  }

                  return Center(child: ProgressView());
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCase(BuildContext context, int todayCases, int cases,
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
              .headline5
              .copyWith(color: higlightColor,fontSize: 22),
        ),
        SizedBox(height: 4,),
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
