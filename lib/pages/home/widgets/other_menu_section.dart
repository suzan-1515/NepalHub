import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/forex_model.dart';
import 'package:samachar_hub/data/models/horoscope_model.dart';
import 'package:samachar_hub/services/services.dart';

class OtherMenuSection extends StatelessWidget {
  final ForexModel forexData;
  final HoroscopeModel horoscopeData;
  const OtherMenuSection({
    Key key,
    this.forexData,
    this.horoscopeData,
  }) : super(key: key);

  Widget _buildForexMenu(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      color: Colors.blue,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.read<NavigationService>().toForexScreen(context),
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
                                  '\n${forexData.unit} ${forexData.code}=NRs. ${forexData.buying}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white)),
                          TextSpan(text: '\n'),
                          TextSpan(
                              text:
                                  '${forexData.formattedDate(forexData.addedDate)}',
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

  Widget _buildHoroscopeMenu(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      color: Colors.deepOrange[600],
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () =>
              context.read<NavigationService>().toHoroscopeScreen(context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Icon(
                    FontAwesomeIcons.starOfDavid,
                    color: Colors.white,
                    size: 32,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        text: 'Horoscope',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                        children: <TextSpan>[
                          TextSpan(
                              text: '\n${horoscopeData.defaultSign}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white)),
                          TextSpan(text: '\n'),
                          TextSpan(
                              text: '${horoscopeData.formattedDate}',
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
    return LimitedBox(
      maxHeight: 100,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: _buildForexMenu(context)),
            SizedBox(width: 4),
            Expanded(child: _buildHoroscopeMenu(context)),
          ],
        ),
      ),
    );
  }
}
