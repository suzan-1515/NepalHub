import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';

const Map<NewsCategory, String> newsCategoryNameByCode = {
  NewsCategory.tops: 'Top Stories',
  NewsCategory.pltc: 'Politics',
  NewsCategory.sprt: 'Sports',
  NewsCategory.scte: 'Technology',
  NewsCategory.wrld: 'World',
  NewsCategory.busi: 'Business',
  NewsCategory.entm: 'Entertainment',
  NewsCategory.hlth: 'Health',
  NewsCategory.blog: 'Blog',
  NewsCategory.oths: 'Uncategorized',
};

final List<NewsCategoryMenuModel> newsCategoryMenus = List.unmodifiable([
  NewsCategoryMenuModel(
      id: '1',
      title: newsCategoryNameByCode[NewsCategory.tops],
      icon: FontAwesomeIcons.newspaper,
      index: 0),
  NewsCategoryMenuModel(
      id: '2',
      title: newsCategoryNameByCode[NewsCategory.pltc],
      icon: Icons.assistant_photo,
      index: 1),
  NewsCategoryMenuModel(
      id: '3',
      title: newsCategoryNameByCode[NewsCategory.sprt],
      icon: FontAwesomeIcons.running,
      index: 2),
  NewsCategoryMenuModel(
      id: '4',
      title: newsCategoryNameByCode[NewsCategory.scte],
      icon: FontAwesomeIcons.phone,
      index: 3),
  NewsCategoryMenuModel(
      id: '5',
      title: newsCategoryNameByCode[NewsCategory.wrld],
      icon: FontAwesomeIcons.globe,
      index: 4),
  NewsCategoryMenuModel(
      id: '6',
      title: newsCategoryNameByCode[NewsCategory.busi],
      icon: FontAwesomeIcons.businessTime,
      index: 5),
  NewsCategoryMenuModel(
      id: '7',
      title: newsCategoryNameByCode[NewsCategory.entm],
      icon: FontAwesomeIcons.tv,
      index: 6),
  NewsCategoryMenuModel(
      id: '8',
      title: newsCategoryNameByCode[NewsCategory.hlth],
      icon: FontAwesomeIcons.hospital,
      index: 7),
  NewsCategoryMenuModel(
      id: '9',
      title: newsCategoryNameByCode[NewsCategory.blog],
      icon: FontAwesomeIcons.blog,
      index: 8),
  NewsCategoryMenuModel(
      id: '10',
      title: newsCategoryNameByCode[NewsCategory.oths],
      icon: FontAwesomeIcons.lightbulb,
      index: 9),
]);
