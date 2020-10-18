import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_type.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/horoscope/horoscope_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';
import 'package:samachar_hub/feature_horoscope/presentation/extensions/horoscope_extensions.dart';
import 'package:samachar_hub/feature_horoscope/utils/provider.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/home_model.dart';

class DailyHoroscope extends StatelessWidget {
  final HomeUIModel homeUIModel;
  const DailyHoroscope({Key key, this.homeUIModel}) : super(key: key);

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).iconTheme.color.withOpacity(0.6),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'default',
          child: Text(
            'Setting',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
      onSelected: (value) => context
          .repository<NavigationService>()
          .toSettingsScreen(context: context),
    );
  }

  Widget _buildSignRow(
      BuildContext context, String sign, String signIcon, String date) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              shape: BoxShape.circle,
            ),
            child: CachedImage(
              signIcon,
              tag: sign,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          RichText(
            text: TextSpan(
              text: sign,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w500),
              children: <TextSpan>[
                TextSpan(
                    text: '\n$date', style: Theme.of(context).textTheme.caption)
              ],
            ),
          ),
          Spacer(),
          _buildPopupMenu(context),
        ],
      ),
    );
  }

  Widget _buildHoroscopeRow(BuildContext context, String horoscope) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 12),
      child: Text(
        horoscope,
        maxLines: 3,
        style: Theme.of(context).textTheme.subtitle1.copyWith(height: 1.3),
      ),
    );
  }

  Widget _buildCard(BuildContext context, HoroscopeUIModel horoscopeUIModel,
      int defaultHoroscopeSign) {
    final sign = horoscopeUIModel.horoscopeEntity
        .signByIndex(defaultHoroscopeSign, Language.NEPALI);
    final signIcon =
        horoscopeUIModel.horoscopeEntity.signIconByIndex(defaultHoroscopeSign);
    final horoscope = horoscopeUIModel.horoscopeEntity
        .horoscopeByIndex(defaultHoroscopeSign, Language.NEPALI);
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () => context.repository<NavigationService>().toHoroscopeDetail(
            context,
            sign,
            signIcon,
            horoscope,
            horoscopeUIModel.horoscopeEntity),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSignRow(
                context, sign, signIcon, horoscopeUIModel.formattedDate),
            Divider(),
            _buildHoroscopeRow(context, horoscope),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HoroscopeProvider.horoscopeBlocProvider(
      type: HoroscopeType.DAILY,
      child: FadeInUp(
        child: BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (previous, current) =>
              (current is SettingsDefaultHoroscopeSignChangedState),
          listener: (context, state) {
            if (state is SettingsDefaultHoroscopeSignChangedState) {
              context.bloc<HoroscopeBloc>().add(
                    RefreshHoroscopeEvent(),
                  );
            }
          },
          child: BlocConsumer<HoroscopeBloc, HoroscopeState>(
            listener: (context, state) {
              if (state is HoroscopeInitialState) {
                context.bloc<HoroscopeBloc>().add(GetHoroscopeEvent());
              }
            },
            buildWhen: (previous, current) => !(current is HoroscopeErrorState),
            builder: (context, state) {
              if (state is HoroscopeLoadSuccessState) {
                homeUIModel.shouldShowDailyHoroscopeSection = true;
                return _buildCard(
                    context, state.horoscope, state.defaultSignIndex);
              }
              homeUIModel.shouldShowDailyHoroscopeSection = false;
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
