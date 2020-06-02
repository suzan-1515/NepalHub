import 'package:flutter/material.dart';

class OtherMenuModel {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final Map<String, dynamic> data;

  OtherMenuModel(
      {@required this.id,
      @required this.title,
      @required this.icon,
      @required this.data,
      @required this.color});
}
