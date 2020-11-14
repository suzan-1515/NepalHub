import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:samachar_hub/core/utils/desclaimer.dart';
import 'package:samachar_hub/core/widgets/webview_widget.dart';

class AboutSettings extends StatelessWidget {
  const AboutSettings({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8),
          ListTile(
            dense: true,
            onTap: () => Navigator.pushNamed(
              context,
              InBuiltWebViewScreen.ROUTE_NAME,
              arguments: InBuiltWebViewScreenArgs(
                  title: 'Privacy Policy',
                  url:
                      'https://suzan-1515.github.io/NepalHub/privacy-policy.html'),
            ),
            title: Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          ListTile(
            dense: true,
            onTap: () {
              LaunchReview.launch(androidAppId: "com.cognota.nepalhub");
            },
            title: Text(
              'Rate us',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          ListTile(
            dense: true,
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationName: 'Nepal Hub',
                  applicationVersion: '1.0.1',
                  applicationLegalese: kDesclaimer,
                  applicationIcon: Image.asset(
                    'assets/icons/logo.png',
                    width: 32,
                    height: 32,
                  ),
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Divider(),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Developed by:',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Sujan Parajuli',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SelectableText(
                      'Email: suzanparajuli@gmail.com',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]);
            },
            title: Text(
              'About',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
