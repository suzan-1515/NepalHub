import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewsCategoryHorzListItem extends StatelessWidget {
  const NewsCategoryHorzListItem({
    Key key,
    @required this.context,
    @required this.name,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  final BuildContext context;
  final String name;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[200]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 48,
                  height: 48,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey[100], shape: BoxShape.circle),
                  child: Icon(
                    icon,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                name,
                style: Theme.of(context).textTheme.subtitle2,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
