import 'package:corona_module/corona.dart';
import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                BackButton(
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Expanded(
              child: CoronaApp(),
            ),
          ],
        ),
      ),
    );
  }
}
