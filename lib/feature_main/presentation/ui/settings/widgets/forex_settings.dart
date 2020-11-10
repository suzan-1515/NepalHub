import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_forex/domain/entities/currency_entity.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/currency/forex_currency_bloc.dart';
import 'package:samachar_hub/feature_forex/utils/provider.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:shimmer/shimmer.dart';

class ForexSettings extends StatefulWidget {
  const ForexSettings({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  _ForexSettingsState createState() => _ForexSettingsState();
}

class _ForexSettingsState extends State<ForexSettings>
    with AutomaticKeepAliveClientMixin {
  Widget _buildCurrencyDropdown(
      List<CurrencyEntity> currencies, String selectedValue) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: (value) {
        widget.context.watch<SettingsCubit>().setdefaultForexCurrency(value);
      },
      items: currencies
          .map(
            (entry) => DropdownMenuItem<String>(
              value: entry.code,
              child: Text(
                entry.title,
                style: Theme.of(widget.context).textTheme.caption,
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final settingsCubit = context.watch<SettingsCubit>();
    return ForexProvider.forexCurrencyBlocProvider(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Default Currency',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            BlocConsumer<ForexCurrencyBloc, ForexCurrencyState>(
              listener: (context, state) {
                if (state is ForexCurrencyErrorState) {
                  context.showMessage(state.message);
                } else if (state is ForexCurrencyLoadErrorState) {
                  context.showMessage(state.message);
                }
              },
              builder: (context, state) {
                if (state is ForexCurrencyLoadSuccessState) {
                  if (settingsCubit.settings.defaultForexCurrency == null) {
                    context
                        .read<SettingsCubit>()
                        .setdefaultForexCurrency(state.currencies.first.code);
                  }
                  return BlocBuilder<SettingsCubit, SettingsState>(
                      buildWhen: (previous, current) =>
                          current is SettingsDefaultForexCurrencyChangedState ||
                          current is SettingsInitialState ||
                          current is SettingsLoadSuccess,
                      builder: (context, _state) {
                        if (_state
                            is SettingsDefaultForexCurrencyChangedState) {
                          return _buildCurrencyDropdown(
                              state.currencies, _state.value);
                        }
                        return _buildCurrencyDropdown(state.currencies,
                            settingsCubit.settings.defaultForexCurrency);
                      });
                }
                return Shimmer.fromColors(
                  child: SizedBox(width: 24, height: 24),
                  baseColor: Theme.of(context).cardColor,
                  highlightColor: Theme.of(context).canvasColor,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
