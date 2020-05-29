import 'package:flutter/material.dart';

class ErrorDataView extends StatelessWidget {
  final Function onRetry;

  const ErrorDataView({Key key, this.onRetry}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Oops something went wrong',style: Theme.of(context).textTheme.bodyText2,),
        RaisedButton(
          child: Text('Retry'),
          onPressed: () {
            onRetry();
          },
        ),
      ],
    );
  }
}
