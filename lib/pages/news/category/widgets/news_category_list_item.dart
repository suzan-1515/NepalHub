import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewsCategoryListItem extends StatelessWidget {
  const NewsCategoryListItem({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.followers,
    @required this.isSubscribed,
    @required this.onTap,
    @required this.onFollowTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final int followers;
  final bool isSubscribed;
  final Function onTap;
  final Function onFollowTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        leading: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1.0,
                  ),
                ],
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: Icon(
              icon,
              size: 32,
              color: Theme.of(context).accentColor.withOpacity(.8),
            )),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '$followers Followers',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              ActionChip(
                backgroundColor:
                    isSubscribed ? Colors.grey : Theme.of(context).accentColor,
                avatar: isSubscribed ? Icon(Icons.check) : null,
                label: Text(
                  isSubscribed ? 'Followed' : 'Follow',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
                onPressed: onFollowTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
