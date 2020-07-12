import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/horoscope_model.dart';
import 'package:samachar_hub/data/models/horoscope_type.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_store.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_type_view.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';

class HoroscopeScreen extends StatefulWidget {
  @override
  _HoroscopeScreenState createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen>
    with SingleTickerProviderStateMixin {
  List<ReactionDisposer> _disposers;
  TabController _tabController;
  final List<Tab> _tabs = <Tab>[
    Tab(key: ValueKey<HoroscopeType>(HoroscopeType.DAILY), text: 'Daily'),
    Tab(key: ValueKey<HoroscopeType>(HoroscopeType.WEEKLY), text: 'Weekly'),
    Tab(key: ValueKey<HoroscopeType>(HoroscopeType.MONTHLY), text: 'Monthly'),
    Tab(key: ValueKey<HoroscopeType>(HoroscopeType.YEARKY), text: 'Yearly'),
  ];

  @override
  void initState() {
    final store = Provider.of<HoroscopeStore>(context, listen: false);
    _setupObserver(store);
    _tabController = TabController(
      initialIndex: store.activeTabIndex,
      vsync: this,
      length: _tabs.length,
    );
    store.loadData();

    super.initState();
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    _tabController.dispose();
    super.dispose();
  }

  _showMessage(String message) {
    if (null != message)
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  _showErrorDialog(APIException apiError) {
    if (null != apiError)
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return ApiErrorDialog(
            apiError: apiError,
          );
        },
      );
  }

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        _showMessage(message);
      }),
      // Listens for API error
      autorun((_) {
        final APIException error = store.apiError;
        _showErrorDialog(error);
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Horoscope'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<HoroscopeStore>(
          builder: (_, HoroscopeStore store, __) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TabBar(
                    controller: _tabController,
                    tabs: _tabs,
                    isScrollable: true,
                  ),
                  Expanded(
                    child: StreamBuilder<Map<HoroscopeType, HoroscopeModel>>(
                      stream: store.dataStream,
                      builder: (_,
                          AsyncSnapshot<Map<HoroscopeType, HoroscopeModel>>
                              snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: ErrorDataView(
                              onRetry: () => store.retry(),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data.isEmpty) {
                            return Center(
                              child: EmptyDataView(),
                            );
                          }
                          return TabBarView(
                            controller: _tabController,
                            children: <Widget>[
                              HoroscopeTypeView(
                                  data: snapshot.data[HoroscopeType.DAILY]),
                              HoroscopeTypeView(
                                  data: snapshot.data[HoroscopeType.WEEKLY]),
                              HoroscopeTypeView(
                                  data: snapshot.data[HoroscopeType.MONTHLY]),
                              HoroscopeTypeView(
                                  data: snapshot.data[HoroscopeType.YEARKY]),
                            ],
                          );
                        }
                        return Center(child: ProgressView());
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
