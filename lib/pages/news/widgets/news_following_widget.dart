import 'package:flutter/material.dart';

class NewsFollowingHeader extends StatelessWidget {
  const NewsFollowingHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).cardColor,
              image: DecorationImage(
                image: AssetImage('assets/images/user.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Corona Virus',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          RaisedButton(
            visualDensity: VisualDensity.compact,
            textColor: Colors.white,
            color: Colors.blue,
            child: Text('Follow'),
            onPressed: () {},
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
