import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/country_bloc/country_bloc.dart';
import '../../../core/models/country.dart';
import '../common/search_box.dart';
import '../indicators/busy_indicator.dart';
import '../indicators/empty_icon.dart';
import '../indicators/error_icon.dart';
import 'country_card.dart';

class CountryList extends StatelessWidget {
  final ScrollController controller;

  const CountryList({
    @required this.controller,
  }) : assert(controller != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        if (state is InitialCountryState) {
          return const EmptyIcon();
        } else if (state is LoadedCountryState) {
          if (state.shouldShowAllCountries) {
            return _buildList(context, state.allCountries);
          }
          return _buildList(context, state.searchedCountries);
        } else if (state is ErrorCountryState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildList(BuildContext context, List<Country> countries) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SearchBox(
          hintText: 'Search Countries',
          onChanged: (String value) {
            context.bloc<CountryBloc>()
              ..add(SearchCountryEvent(
                searchTerm: value,
              ));
          },
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            controller: controller,
            itemCount: countries.length,
            itemBuilder: (context, index) => CountryCard(
              country: countries[index],
            ),
          ),
        ),
      ],
    );
  }
}
