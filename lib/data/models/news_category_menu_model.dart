import 'package:flutter/material.dart';

class NewsCategoryMenuModel {
  final String id;
  final String title;
  final IconData icon;
  final int index;

  NewsCategoryMenuModel({@required this.id, @required this.title, this.icon, @required this.index});
}
