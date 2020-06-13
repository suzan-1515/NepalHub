import 'package:flutter/material.dart';

import '../widgets/common/collapsible_appbar.dart';
import '../widgets/info_page/faq_list.dart';
import '../widgets/info_page/hospital_list.dart';
import '../widgets/info_page/info_tab_bar.dart';
import '../widgets/info_page/myth_list.dart';
import '../widgets/info_page/podcast_list.dart';

class InfoPage extends StatelessWidget {
  const InfoPage();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
            const CollapsibleAppBar(
              elevation: 0.0,
              title: 'INFO',
              imageUrl: 'assets/images/info_header.png',
            ),
            const InfoTabBar(),
          ],
          body: TabBarView(
            children: <Widget>[
              const PodcastList(),
              const MythList(),
              const FaqList(),
              const HospitalList(),
            ],
          ),
        ),
      ),
    );
  }
}
