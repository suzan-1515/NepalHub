import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/view/view_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/detail/widgets/zodiac_info.dart';
import 'package:samachar_hub/feature_horoscope/utils/provider.dart';
import 'package:scoped_model/scoped_model.dart';

import 'widgets/horoscope_comment.dart';

class HoroscopeDetailScreen extends StatelessWidget {
  final int signIndex;
  final HoroscopeUIModel horoscopeUIModel;

  const HoroscopeDetailScreen({
    Key key,
    @required this.signIndex,
    @required this.horoscopeUIModel,
  }) : super(key: key);

  static Future navigate(
      {@required BuildContext context,
      @required HoroscopeUIModel horoscopeUIModel,
      @required int signIndex}) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HoroscopeDetailScreen(
            horoscopeUIModel: horoscopeUIModel,
            signIndex: signIndex,
          ),
        ));
  }

  Widget _buildAdView(context, store) {
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

  @override
  Widget build(BuildContext context) {
    return HoroscopeProvider.horoscopeDetailBlocProvider(
      horoscope: horoscopeUIModel.entity,
      child: ScopedModel<HoroscopeUIModel>(
        model: horoscopeUIModel,
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
              title: Text(HOROSCOPE_SIGNS[Language.NEPALI][signIndex]),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    GetIt.I
                        .get<NavigationService>()
                        .toSettingsScreen(context: context);
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ZodiacInfo(signIndex: signIndex),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: HoroscopeComment(signIndex: signIndex),
            ),
          ),
        ),
      ),
    );
  }
}
