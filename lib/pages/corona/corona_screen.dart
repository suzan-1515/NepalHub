import 'package:flutter/material.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';

class CoronaScreen extends StatefulWidget {
  @override
  _CoronaScreenState createState() => _CoronaScreenState();
}

class _CoronaScreenState extends State<CoronaScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          color: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  BackButton(
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  PageHeading(
                    title: 'Corona Updates',
                  ),
                ],
              ),
              Expanded(
                child: Center(child: Text('Corona Page')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
