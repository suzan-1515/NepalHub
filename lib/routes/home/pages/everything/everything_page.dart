import 'package:flutter/material.dart';

class EverythingPage extends StatefulWidget {
  @override
  _EverythingPageState createState() => _EverythingPageState();
}

class _EverythingPageState extends State<EverythingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child:
                Text('Everything', style: Theme.of(context).textTheme.headline),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
