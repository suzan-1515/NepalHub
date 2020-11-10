import 'package:flutter/material.dart';

class CommentDeleteConfirmationDialog extends StatelessWidget {
  final Function onYesTap;
  final Function onNoTap;

  const CommentDeleteConfirmationDialog(
      {Key key, @required this.onYesTap, @required this.onNoTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete this comment?'),
      actions: [
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            onYesTap();
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            onNoTap();
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
