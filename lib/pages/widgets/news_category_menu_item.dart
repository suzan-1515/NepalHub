import 'package:flutter/material.dart';
import 'package:samachar_hub/data/dto/news_category_menu_dto.dart';

class NewsCategoryMenuItem extends StatelessWidget {
  final NewsCategoryMenu category;
  final Function onTap;

  const NewsCategoryMenuItem(
      {Key key, @required this.category, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[200]),
          borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => onTap(category),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey[100], shape: BoxShape.circle),
                  child: Icon(
                    category.icon,
                    color: Theme.of(context).accentColor,
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
    );
  }
}
