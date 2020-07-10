import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddListItem extends StatelessWidget {
  const AddListItem({
    Key key,
    @required this.context,
    @required this.onTap,
  }) : super(key: key);

  final BuildContext context;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Icon(
                  FontAwesomeIcons.plusCircle,
                  color: Theme.of(context).accentColor.withOpacity(.7),
                  size: 32,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add',
                  style: Theme.of(context).textTheme.subtitle2,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
