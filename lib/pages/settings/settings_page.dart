import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/settings/settings_store.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  // Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _setupObserver();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }

  _setupObserver() {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message =
            Provider.of<SettingsStore>(context, listen: false).message;
        _showMessage(message);
      }),
    ];
  }

  _showMessage(String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PageHeading(title:'Settings'),
          Expanded(
            child: Consumer<SettingsStore>(
              builder: (BuildContext context, SettingsStore settingsStore,
                  Widget child) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Theme.of(context).dividerColor)),
                            ),
                            padding: EdgeInsets.only(bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.paintRoller,
                                  color: Theme.of(context).accentColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Customization',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Observer(
                            builder: (_) => Padding(
                              padding: const EdgeInsets.only(left: 16, top: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AbsorbPointer(
                                    absorbing: settingsStore.themeSetBySystem,
                                    child: Opacity(
                                      opacity: settingsStore.themeSetBySystem
                                          ? 0.45
                                          : 1.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Use dark theme',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Switch(
                                            value: settingsStore.useDarkMode,
                                            onChanged:
                                                settingsStore.setDarkMode,
                                            activeColor:
                                                Theme.of(context).accentColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4),
                                                child: Text(
                                                  'Use pitch black theme',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                ),
                                              ),
                                              Text(
                                                'Only applies when dark mode is on',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Checkbox(
                                          value: settingsStore.usePitchBlack,
                                          onChanged:
                                              settingsStore.setPitchBlack,
                                          activeColor:
                                              Theme.of(context).accentColor,
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: AbsorbPointer(
                                      absorbing: settingsStore.useDarkMode,
                                      child: Opacity(
                                        opacity: settingsStore.useDarkMode
                                            ? 0.45
                                            : 1.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 4),
                                                    child: Text(
                                                      'Theme set by system',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Requires minimum OS version ${Platform.isAndroid ? 'Android 10' : 'IOS 13'}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Checkbox(
                                              value: settingsStore
                                                  .themeSetBySystem,
                                              onChanged:
                                                  settingsStore.setSystemTheme,
                                              activeColor:
                                                  Theme.of(context).accentColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
