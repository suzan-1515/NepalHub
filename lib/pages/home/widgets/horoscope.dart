import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/horoscope_model.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/utils/horoscope_signs.dart';
import 'package:samachar_hub/widgets/cached_image_widget.dart';

class DailyHoroscope extends StatelessWidget {
  final HoroscopeModel data;

  const DailyHoroscope({Key key, @required this.data}) : super(key: key);

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).iconTheme.color.withOpacity(0.6),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'default',
          child: Text(
            'Setting',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
      onSelected: (value) =>
          context.read<NavigationService>().toSettingsScreen(context: context),
    );
  }

  Widget _buildSignRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              shape: BoxShape.circle,
            ),
            child: CachedImage(
              horoscopeSignIcons[data.defaultSignIndex],
              tag: data.defaultSign,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          RichText(
            text: TextSpan(
              text: data.defaultSign,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w500),
              children: <TextSpan>[
                TextSpan(
                    text: '\n${data.formattedDate}',
                    style: Theme.of(context).textTheme.caption)
              ],
            ),
          ),
          Spacer(),
          _buildPopupMenu(context),
        ],
      ),
    );
  }

  Widget _buildHoroscopeRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 12),
      child: Text(
        data.defaultHoroscope,
        maxLines: 3,
        style: Theme.of(context).textTheme.subtitle1.copyWith(height: 1.3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () => context.read<NavigationService>().toHoroscopeDetail(
            context,
            data.defaultSign,
            horoscopeSignIcons[data.defaultSignIndex],
            data.defaultHoroscope,
            data),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSignRow(context),
            Divider(),
            _buildHoroscopeRow(context),
          ],
        ),
      ),
    );
  }
}
