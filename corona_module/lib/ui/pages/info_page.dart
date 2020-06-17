import 'package:corona_module/ui/styles/styles.dart';
import 'package:flutter/material.dart';

import '../widgets/info_page/faq_list.dart';
import '../widgets/info_page/hospital_list.dart';
import '../widgets/info_page/myth_list.dart';
import '../widgets/info_page/podcast_list.dart';

class InfoPage extends StatelessWidget {
  const InfoPage();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Info',
            maxLines: 3,
            style: AppTextStyles.extraLargeLight.copyWith(
              fontSize: 32.0,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelStyle: AppTextStyles.smallLight,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.light,
            indicatorWeight: 2.0,
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              const Tab(
                text: 'PODCASTS',
              ),
              const Tab(
                text: 'MYTHS',
              ),
              const Tab(
                text: 'FAQ',
              ),
              const Tab(
                text: 'HOSPITALS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            const PodcastList(),
            const MythList(),
            const FaqList(),
            const HospitalList(),
          ],
        ),
      ),
    );
  }
}
