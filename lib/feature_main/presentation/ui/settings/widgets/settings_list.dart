import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/feature_main/domain/entities/settings_entity.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/widgets/about_settings.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/widgets/forex_settings.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/widgets/general_settings.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/widgets/horoscope_settings.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/widgets/news_settings.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/widgets/notification_settings.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/widgets/section_heading.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/widgets/theme_settings.dart';

class SettingsList extends StatelessWidget {
  final SettingsEntity settings;

  const SettingsList({Key key, @required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SectionHeading(
            title: 'General',
            icon: FontAwesomeIcons.sitemap,
          ),
          GeneralSettings(context: context),
          SizedBox(height: 16),
          SectionHeading(
            title: 'News',
            icon: FontAwesomeIcons.newspaper,
          ),
          NewsSettings(context: context, settingsEntity: settings),
          SizedBox(height: 16),
          SectionHeading(
            title: 'Forex',
            icon: FontAwesomeIcons.chartLine,
          ),
          ForexSettings(context: context, settingsEntity: settings),
          SizedBox(height: 16),
          SectionHeading(
            title: 'Horoscope',
            icon: FontAwesomeIcons.starOfDavid,
          ),
          HoroscopeSettings(context: context, settingsEntity: settings),
          SizedBox(height: 16),
          SectionHeading(
            title: 'App Theme',
            icon: FontAwesomeIcons.adjust,
          ),
          ThemeSettings(settingsEntity: settings, context: context),
          SizedBox(height: 16),
          SectionHeading(
            title: 'Notification',
            icon: FontAwesomeIcons.bell,
          ),
          NotificationSettings(context: context, settingsEntity: settings),
          SizedBox(height: 16),
          SectionHeading(
            title: 'About',
            icon: FontAwesomeIcons.infoCircle,
          ),
          AboutSettings(context: context, settingsEntity: settings),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
