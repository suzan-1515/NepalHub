import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/models/horoscope_model.dart';
import 'package:samachar_hub/pages/horoscope/widgets/horoscope_list.dart';

class HoroscopeView extends StatelessWidget {
  final HoroscopeModel data;

  const HoroscopeView({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 200),
      child: HoroscopeList(data: data),
    );
  }
}
