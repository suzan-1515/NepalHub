import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/view/view_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/detail/widgets/zodiac_info.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/horoscope_detail_screen_arguments.dart';
import 'package:samachar_hub/feature_horoscope/utils/provider.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/settings_page.dart';
import 'package:scoped_model/scoped_model.dart';

import 'widgets/horoscope_comment.dart';

class HoroscopeDetailScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/horoscope-detail';
  const HoroscopeDetailScreen({
    Key key,
  }) : super(key: key);

  // Widget _buildAdView(context, store) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  //     height: 60,
  //     color: Colors.amber,
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           child: Center(child: Text('Ad section')),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final HoroscopeDetailScreenArgs args =
        ModalRoute.of(context).settings.arguments;
    return HoroscopeProvider.horoscopeDetailBlocProvider(
      horoscope: args.horoscopeUIModel.entity,
      child: ScopedModel<HoroscopeUIModel>(
        model: args.horoscopeUIModel,
        child: MultiBlocListener(
          listeners: [
            BlocListener<LikeUnlikeBloc, LikeUnlikeState>(
              listener: (context, state) {
                if (state is LikedState) {
                  ScopedModel.of<HoroscopeUIModel>(context).entity =
                      state.horoscope;
                } else if (state is UnlikedState) {
                  ScopedModel.of<HoroscopeUIModel>(context).entity =
                      state.horoscope;
                }
              },
            ),
            BlocListener<ShareBloc, ShareState>(
              listener: (context, state) {
                if (state is ShareSuccess) {
                  ScopedModel.of<HoroscopeUIModel>(context).entity =
                      state.horoscope;
                }
              },
            ),
            BlocListener<ViewBloc, ViewState>(
              listener: (context, state) {
                if (state is ViewSuccess) {
                  ScopedModel.of<HoroscopeUIModel>(context).entity =
                      state.horoscope;
                }
              },
            ),
          ],
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: Text(HOROSCOPE_SIGNS[Language.NEPALI][args.signIndex]),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(context, SettingsScreen.ROUTE_NAME);
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ZodiacInfo(signIndex: args.signIndex),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: HoroscopeComment(signIndex: args.signIndex),
            ),
          ),
        ),
      ),
    );
  }
}
