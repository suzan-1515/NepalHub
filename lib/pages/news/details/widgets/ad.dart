import 'package:flutter/material.dart';

class Ad extends StatelessWidget {
  const Ad({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      height: 60,
      color: Colors.amber,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(child: Text('Ad section')),
          ),
        ],
      ),
    );
  }
}
