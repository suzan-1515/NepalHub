import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/news.dart';
import '../../../core/services/launcher_service.dart';
import '../../styles/styles.dart';
import '../common/tag.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final Color color;

  const NewsCard({
    @required this.news,
    this.color = AppColors.primary,
  }) : assert(news != null);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 11 / 16,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: NetworkImage(news.imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              AppColors.background.withOpacity(0.85),
              BlendMode.srcATop,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTitle(),
            Divider(height: 16.0, color: color.withOpacity(0.4)),
            _buildSummary(),
            Divider(height: 16.0, color: color.withOpacity(0.4)),
            _buildSource(),
            const SizedBox(height: 16.0),
            _buildReadMore(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Flexible(
      child: Text(
        news.title,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: AppTextStyles.extraLargeLightSerif,
      ),
    );
  }

  Widget _buildSummary() {
    return Flexible(
      child: SingleChildScrollView(
        child: Text(
          news.summary,
          textAlign: TextAlign.justify,
          style: AppTextStyles.mediumLight,
        ),
      ),
    );
  }

  Widget _buildSource() {
    final DateTime c = news.createdAt;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          news.source,
          style: AppTextStyles.extraSmallLight,
        ),
        Text(
          '${c.year}/${c.month}/${c.day}',
          textAlign: TextAlign.left,
          style: AppTextStyles.extraSmallLight,
        ),
      ],
    );
  }

  Widget _buildReadMore(BuildContext context) {
    return Tag(
      label: 'READ MORE',
      color: color,
      onPressed: () async {
        await context
            .repository<LauncherService>()
            .launchWebsite(context, news.url);
      },
    );
  }
}
