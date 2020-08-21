import 'package:flutter/material.dart';
import 'package:samachar_hub/pages/news/widgets/outline_rounded_button.dart';

class ReportArticle extends StatelessWidget {
  final String articleId;
  final String articleType;

  const ReportArticle({
    Key key,
    @required this.articleId,
    @required this.articleType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 4,
          ),
          Text(
            'Report',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 4,
          ),
          Divider(),
          Text(
            'You can report this article with a reason below',
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(
            height: 4,
          ),
          Wrap(
            spacing: 4.0,
            children: [
              ReportOptionButton(
                text: 'Fake news',
                onTap: () {},
              ),
              ReportOptionButton(
                text: 'Clickbait',
                onTap: () {},
              ),
              ReportOptionButton(
                text: 'Old or repetative news',
                onTap: () {},
              ),
              ReportOptionButton(
                text: 'Adult',
                onTap: () {},
              ),
              ReportOptionButton(
                text: 'Other',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
