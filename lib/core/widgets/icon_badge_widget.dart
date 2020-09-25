import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IconBadge extends StatelessWidget {
  const IconBadge({
    Key key,
    @required this.iconData,
    @required this.badgeText,
    @required this.onTap,
  }) : super(key: key);

  final IconData iconData;
  final String badgeText;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        children: <Widget>[
          IconButton(
            icon: Icon(
              iconData,
              size: 16,
            ),
            onPressed: onTap,
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(0.7),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Text(badgeText,
                  style: Theme.of(context).textTheme.overline.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500)),
            ),
          )
        ],
      ),
    );
  }
}
