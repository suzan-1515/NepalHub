import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/news_category_menu_dto.dart';

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

final List<NewsCategoryMenu> newsCategoryMenus = List.unmodifiable([
  NewsCategoryMenu(
      id: '1',
      title: newsCategoryNameByCode[NewsCategory.tops],
      icon: FontAwesomeIcons.newspaper,
      index: 0),
  NewsCategoryMenu(
      id: '2',
      title: newsCategoryNameByCode[NewsCategory.pltc],
      icon: Icons.assistant_photo,
      index: 1),
  NewsCategoryMenu(
      id: '3',
      title: newsCategoryNameByCode[NewsCategory.sprt],
      icon: FontAwesomeIcons.running,
      index: 2),
  NewsCategoryMenu(
      id: '4',
      title: newsCategoryNameByCode[NewsCategory.scte],
      icon: FontAwesomeIcons.phone,
      index: 3),
  NewsCategoryMenu(
      id: '5',
      title: newsCategoryNameByCode[NewsCategory.wrld],
      icon: FontAwesomeIcons.globe,
      index: 4),
  NewsCategoryMenu(
      id: '6',
      title: newsCategoryNameByCode[NewsCategory.busi],
      icon: FontAwesomeIcons.businessTime,
      index: 5),
  NewsCategoryMenu(
      id: '7',
      title: newsCategoryNameByCode[NewsCategory.entm],
      icon: FontAwesomeIcons.tv,
      index: 6),
  NewsCategoryMenu(
      id: '8',
      title: newsCategoryNameByCode[NewsCategory.hlth],
      icon: FontAwesomeIcons.hospital,
      index: 7),
  NewsCategoryMenu(
      id: '9',
      title: newsCategoryNameByCode[NewsCategory.blog],
      icon: FontAwesomeIcons.blog,
      index: 8),
  NewsCategoryMenu(
      id: '10',
      title: newsCategoryNameByCode[NewsCategory.oths],
      icon: FontAwesomeIcons.lightbulb,
      index: 9),
]);
