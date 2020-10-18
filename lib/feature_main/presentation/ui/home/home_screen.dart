import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/home_feed_list.dart';
import 'package:samachar_hub/feature_main/utils/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return HomeProvider.homeBlocProvider(
      child: Container(
        width: size.width,
        height: size.height,
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: HomeFeedList(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
