import 'package:flutter/material.dart';

class ViewAllButton extends StatelessWidget {
  const ViewAllButton({
    Key key,
    @required this.context,
    @required this.onTap,
  }) : super(key: key);

  final BuildContext context;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      child: Text(
        'View all and Manage',
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.blue),
      ),
    );
  }
}
