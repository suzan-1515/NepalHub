import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex_detail/forex_detail_screen.dart';
import 'package:samachar_hub/feature_gold/presentation/models/gold_silver_model.dart';
import 'package:samachar_hub/feature_gold/presentation/extensions/gold_silver_extensions.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/gold_silver/gold_silver_screen.dart';

class OtherMenuSection extends StatefulWidget {
  final ForexUIModel forex;
  final GoldSilverUIModel goldSilver;
  const OtherMenuSection({
    Key key,
    @required this.forex,
    @required this.goldSilver,
  }) : super(key: key);

  @override
  _OtherMenuSectionState createState() => _OtherMenuSectionState();
}

class _OtherMenuSectionState extends State<OtherMenuSection>
    with AutomaticKeepAliveClientMixin {
  Widget _buildForexMenu(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      color: Colors.blue,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pushNamed(
              context, ForexDetailScreen.ROUTE_NAME,
              arguments: widget.forex),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Icon(
                    FontAwesomeIcons.chartLine,
                    color: Colors.white,
                    size: 32,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        text: 'Forex',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  '\n${widget.forex.entity.unit} ${widget.forex.entity.currency.code}=NRs. ${widget.forex.entity.buying}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white)),
                          TextSpan(text: '\n'),
                          TextSpan(
                              text: '${widget.forex.entity.formatttedDate}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.white)),
                        ]),
                  ),
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoldSilverMenu(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      color: Colors.deepOrange[600],
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, GoldSilverScreen.ROUTE_NAME,
              arguments: widget.goldSilver),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Icon(
                    FontAwesomeIcons.coins,
                    color: Colors.white,
                    size: 32,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        text:
                            'NRs. ${widget.goldSilver.entity.price.formattedString}',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  '\n${widget.goldSilver.entity.category.title} (${widget.goldSilver.entity.unit == 'tola' ? 'Tola' : '10 gms'})',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white)),
                          TextSpan(text: '\n'),
                          TextSpan(
                              text:
                                  '${widget.goldSilver.entity.publishedAt.formattedString}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.white)),
                        ]),
                  ),
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LimitedBox(
      maxHeight: 140,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: _buildForexMenu(context)),
            SizedBox(width: 4),
            Expanded(child: _buildGoldSilverMenu(context)),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
