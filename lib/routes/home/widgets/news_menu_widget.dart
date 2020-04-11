import 'package:flutter/material.dart';
import 'package:samachar_hub/routes/home/pages/pages.dart';

class NewsViewMenuItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final MenuItem value;

  const NewsViewMenuItem(this.icon, this.color, this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem<MenuItem>(
      value: value,
      child: Row(
        children: <Widget>[
          Icon(icon, color: color),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              title,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
