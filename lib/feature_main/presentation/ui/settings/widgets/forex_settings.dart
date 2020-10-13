import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_forex/domain/entities/currency_entity.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/get_currencies_use_case.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/currency/forex_currency_bloc.dart';
import 'package:samachar_hub/feature_main/domain/entities/settings_entity.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:shimmer/shimmer.dart';

class ForexSettings extends StatelessWidget {
  const ForexSettings({
    Key key,
    @required this.context,
    @required this.settingsEntity,
  }) : super(key: key);

  final BuildContext context;
  final SettingsEntity settingsEntity;

  Widget _buildCurrencyDropdown(
      List<CurrencyEntity> currencies, String selectedValue) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: (value) {
        context.bloc<SettingsCubit>().setdefaultForexCurrency(value);
      },
      items: currencies
          .map(
            (entry) => DropdownMenuItem<String>(
              value: entry.code,
              child: Text(
                entry.code,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Default Currency',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          BlocConsumer<ForexCurrencyBloc, ForexCurrencyState>(
            cubit: ForexCurrencyBloc(
              getForexCurrenciesUseCase:
                  context.repository<GetForexCurrenciesUseCase>(),
            )..add(GetForexCurrencies()),
            listener: (context, state) {
              if (state is ForexCurrencyErrorState) {
                context.showMessage(state.message);
              } else if (state is ForexCurrencyLoadErrorState) {
                context.showMessage(state.message);
              }
            },
            builder: (context, state) {
              if (state is ForexCurrencyLoadSuccessState) {
                if (settingsEntity.defaultForexCurrency == null) {
                  context
                      .bloc<SettingsCubit>()
                      .setdefaultForexCurrency(state.currencies.first.code);
                }
                return BlocBuilder<SettingsCubit, SettingsState>(
                    buildWhen: (previous, current) =>
                        current is SettingsDefaultForexCurrencyChangedState ||
                        current is SettingsInitialState,
                    builder: (context, _state) {
                      if (_state is SettingsDefaultForexCurrencyChangedState) {
                        return _buildCurrencyDropdown(
                            state.currencies, _state.value);
                      }
                      return _buildCurrencyDropdown(state.currencies,
                          settingsEntity.defaultForexCurrency);
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
    );
  }
}
