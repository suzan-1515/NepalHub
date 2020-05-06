import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/service/navigation_service.dart';
import 'package:samachar_hub/data/dto/news_category_dto.dart';

class NewsCategoryMenuItem extends StatelessWidget {
  final NewsCategoryMenu category;

  const NewsCategoryMenuItem({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationService>(
      builder: (context, navigationService, _) {
        return Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey[200]),
              borderRadius: BorderRadius.circular(8)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => navigationService.onCategoryMenuClick(
                  category: category, context: context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).backgroundColor,
                          child: Icon(
                            category.icon,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      category.title,
                      style: Theme.of(context).textTheme.body1,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
