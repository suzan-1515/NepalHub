import 'package:flutter/material.dart';
import 'package:samachar_hub/data/api/api_exception.dart';

class ApiErrorDialog extends StatelessWidget {
  final APIException apiError;

  const ApiErrorDialog({Key key, @required this.apiError}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        'API Error - ${apiError.message}',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      content: SingleChildScrollView(
        child: Text(
          apiError.message,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
