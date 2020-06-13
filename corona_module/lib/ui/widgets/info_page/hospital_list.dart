import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/hospital_bloc/hospital_bloc.dart';
import '../../../core/models/hospital.dart';
import '../../styles/styles.dart';
import '../common/search_box.dart';
import '../indicators/busy_indicator.dart';
import '../indicators/empty_icon.dart';
import '../indicators/error_icon.dart';
import 'hospital_details/hospital_card.dart';


class HospitalList extends StatelessWidget {
  const HospitalList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 64.0),
      children: [
        const SizedBox(height: 8.0),
        SearchBox(
          hintText: 'Search Hospitals',
          onChanged: (String value) {
            context.bloc<HospitalBloc>()
              ..add(SearchHospitalEvent(
                searchTerm: value,
              ));
          },
        ),
        const SizedBox(height: 8.0),
        BlocBuilder<HospitalBloc, HospitalState>(
          builder: (context, state) {
            if (state is InitialHospitalState) {
              return const EmptyIcon();
            } else if (state is LoadedHospitalState) {
              return _buildList(state.hospitals);
            } else if (state is ErrorHospitalState) {
              return ErrorIcon(message: state.message);
            } else {
              return const BusyIndicator();
            }
          },
        ),
      ],
    );
  }

  Widget _buildList(List<Hospital> hospitals) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: hospitals.length,
      itemBuilder: (_, index) => HospitalCard(
        hospital: hospitals[index],
        color: AppColors.accentColors[index % AppColors.accentColors.length],
      ),
    );
  }
}
